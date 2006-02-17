prepare_manual() {
  kind="$1"
  top="$(pwd)"

  cd html/$kind
  make
  cd $top

  mkdir -p mandist/manual/$kind/images/callouts
  cp html/*.css html/$kind/*.html mandist/manual/$kind
  cp /home/martin/.nix-profile/xml/xsl/docbook/images/*.png mandist/manual/$kind/images/
  cp /home/martin/.nix-profile/xml/xsl/docbook/images/callouts/*.png mandist/manual/$kind/images/callouts

  cd doc
  find . \
        -name *.png \
    -or -name *.str \
    -or -name *.sdf \
    -or -name *.str \
    -or -name *.rtg \
    -or -name *.pp \
    -or -name *.meta | xargs -i cp -v --parents {} ../mandist/manual/$kind

  cd $top/svg
  find . -name *.png  | xargs -i cp --parents {} ../mandist/manual/$kind

  cd $top
  cp src/examples.tar.gz mandist/manual/$kind
  cd mandist/manual/$kind
  tar zxvf $top/src/examples-full.tar.gz
}

prepare_mandist() {
  kind="$1"
  top="$(pwd)"
  distdir=strategoxt-manual-$kind-0.16pre14477

  cd mandist/manual
  rm -rf $distdir
  mv $kind $distdir
  tar cvfj ../$distdir.tar.bz2 $distdir
  tar cvfz ../$distdir.tar.gz $distdir
  zip -r ../$distdir.zip $distdir
}