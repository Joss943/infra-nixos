{ config, pkgs, lib, ... }:

{
  ##################################################
  # GVFS / GNOME Keyring
  ##################################################

  services.gvfs.enable = true;

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  services.gnome.core-apps.enable = true;

  ##################################################
  # Packages
  ##################################################

  environment.systemPackages = with pkgs; [
    cifs-utils
    samba4Full
    keyutils

    gvfs
    nautilus
    gnome-online-accounts
  ];

  ##################################################
  # Script systeme de montage SMB
  ##################################################

  environment.etc."mount-drives.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Attente chargement session GNOME
      sleep 20

      # Groupes de l'utilisateur recuperes une seule fois
      GROUPS="$(id -nG)"

      # Identifiant sans suffixe @domaine (pour les partages personnels)
      USERNAME="$(id -un | cut -d@ -f1)"

      ##################################################
      # RACA/R  —  Région Île-De-France
      ##################################################

      if grep -qw "gg_raca_lecteur_r" <<< "$GROUPS"; then
        nautilus "smb://ad-idf.in.region-academique-idf.fr/RACA/R"
      fi

      ##################################################
      # DSDEN78/DAFCO  —  DAFCO
      ##################################################

      if grep -qw "gl_200_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/DAFCO"
      fi

      ##################################################
      # DSDEN78/S  —  SPECIFIQUE78
      ##################################################

      if grep -qw "gl_sa78_s_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/S"
      fi

      ##################################################
      # DSDEN78/p/201  —  SDEI
      ##################################################

      if grep -qw "gl_sa78_sdei_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/201"
      fi

      ##################################################
      # DSDEN78/p/202  —  CELLULE_TICE
      ##################################################

      if grep -qw "gl_sa78_cellule_tice_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/202"
      fi

      ##################################################
      # DSDEN78/p/203  —  CIRCO_LE_CHESNAY
      ##################################################

      if grep -qw "gl_sa78_circo_le_chesnay_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/203"
      fi

      ##################################################
      # DSDEN78/p/204  —  CONTROLE_DE_GESTION
      ##################################################

      if grep -qw "gl_sa78_controle_de_gestion_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/204"
      fi

      ##################################################
      # DSDEN78/p/205  —  DIRECTION
      ##################################################

      if grep -qw "gl_sa78_direction_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/205"
      fi

      ##################################################
      # DSDEN78/p/206  —  DOS
      ##################################################

      if grep -qw "gl_sa78_dos_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/206"
      fi

      ##################################################
      # DSDEN78/p/207  —  DP
      ##################################################

      if grep -qw "gl_sa78_dp_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/207"
      fi

      ##################################################
      # DSDEN78/p/208  —  DRH
      ##################################################

      if grep -qw "gl_sa78_drh_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/208"
      fi

      ##################################################
      # DSDEN78/p/209  —  DVSCO
      ##################################################

      if grep -qw "gl_sa78_dvsco_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/209"
      fi

      ##################################################
      # DSDEN78/p/210  —  EPS
      ##################################################

      if grep -qw "gl_sa78_eps_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/210"
      fi

      ##################################################
      # DSDEN78/p/211  —  IENIO_MLDS
      ##################################################

      if grep -qw "gl_sa78_ienio_mlds_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/211"
      fi

      ##################################################
      # DSDEN78/p/212  —  DATCP
      ##################################################

      if grep -qw "gl_sa78_datcp_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/212"
      fi

      ##################################################
      # DSDEN78/p/213  —  SERVICE_INFIRMIERS_ET_SOCIAUX
      ##################################################

      if grep -qw "gl_sa78_service_infirmiers_et_sociaux_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/213"
      fi

      ##################################################
      # DSDEN78/p/214  —  SPSFE
      ##################################################

      if grep -qw "gl_sa78_spsfe_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/214"
      fi

      ##################################################
      # DSDEN78/p/215  —  SDJES78
      ##################################################

      if grep -qw "gl_sa78_sdjes78_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/215"
      fi

      ##################################################
      # DSDEN91/P/401  —  Cabinet
      ##################################################

      if grep -qw "gl_sa91_cabinet_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/401"
      fi

      ##################################################
      # DSDEN91/P/402  —  SG
      ##################################################

      if grep -qw "gl_sa91_sg_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/402"
      fi

      ##################################################
      # DSDEN91/P/403  —  IENA
      ##################################################

      if grep -qw "gl_sa91_iena_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/403"
      fi

      ##################################################
      # DSDEN91/P/404  —  SAB
      ##################################################

      if grep -qw "gl_sa91_sab_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/404"
      fi

      ##################################################
      # DSDEN91/P/405  —  DOS
      ##################################################

      if grep -qw "gl_sa91_dos_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/405"
      fi

      ##################################################
      # DSDEN91/P/406  —  DGRH
      ##################################################

      if grep -qw "gl_sa91_dgrh_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/406"
      fi

      ##################################################
      # DSDEN91/P/407  —  DIPER
      ##################################################

      if grep -qw "gl_sa91_diper_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/407"
      fi

      ##################################################
      # DSDEN91/P/408  —  DIPE
      ##################################################

      if grep -qw "gl_sa91_dipe_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/408"
      fi

      ##################################################
      # DSDEN91/P/409  —  DAR
      ##################################################

      if grep -qw "gl_sa91_dar_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/409"
      fi

      ##################################################
      # DSDEN91/P/410  —  Service Social Eleves
      ##################################################

      if grep -qw "gl_sa91_sce_social_eleves_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/410"
      fi

      ##################################################
      # DSDEN91/P/411  —  Service Sante Eleves
      ##################################################

      if grep -qw "gl_sa91_sce_sante_eleves_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/411"
      fi

      ##################################################
      # DSDEN91/P/412  —  Service Social Personnel
      ##################################################

      if grep -qw "gl_sa91_sce_social_personnel_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/412"
      fi

      ##################################################
      # DSDEN91/P/413  —  ASH
      ##################################################

      if grep -qw "gl_sa91_ash_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/413"
      fi

      ##################################################
      # DSDEN91/P/414  —  CASNAV
      ##################################################

      if grep -qw "gl_sa91_casnav_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/414"
      fi

      ##################################################
      # DSDEN91/P/415  —  PVS
      ##################################################

      if grep -qw "gl_sa91_pvs_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/415"
      fi

      ##################################################
      # DSDEN91/P/416  —  IENIO
      ##################################################

      if grep -qw "gl_sa91_ienio_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/416"
      fi

      ##################################################
      # DSDEN91/P/417  —  sante personnel 91
      ##################################################

      if grep -qw "gl_sa91_sce_sante_personnel_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/417"
      fi

      ##################################################
      # DSDEN91/P/418  —  PAIRE91
      ##################################################

      if grep -qw "gl_sa91_paire91_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/418"
      fi

      ##################################################
      # DSDEN91/P/419  —  CAEVJRM
      ##################################################

      if grep -qw "gl_sa91_caevjrm_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/419"
      fi

      ##################################################
      # DSDEN91/P/423  —  SDJES91
      ##################################################

      if grep -qw "gl_sa91_sdjes91_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/423"
      fi

      ##################################################
      # DSDEN91/P/424  —  DEI
      ##################################################

      if grep -qw "gl_sa91_dei_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/424"
      fi

      ##################################################
      # DSDEN91/P/425  —  DACP
      ##################################################

      if grep -qw "gl_sa91_dacp_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/425"
      fi

      ##################################################
      # DSDEN91/S  —  SPECIFIQUE91
      ##################################################

      if grep -qw "gl_sa91_s_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN91/S"
      fi

      ##################################################
      # DSDEN95/P/601  —  Direction
      ##################################################

      if grep -qw "gl_sa95_direction_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/P/601"
      fi

      ##################################################
      # DSDEN95/S  —  SPECIFIQUE95
      ##################################################

      if grep -qw "gl_sa95_s_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/S"
      fi

      ##################################################
      # DSDEN95/p/602  —  IENA
      ##################################################

      if grep -qw "gl_sa95_iena_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/602"
      fi

      ##################################################
      # DSDEN95/p/603  —  DMPP
      ##################################################

      if grep -qw "gl_sa95_dmpp_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/603"
      fi

      ##################################################
      # DSDEN95/p/604  —  CASNAV
      ##################################################

      if grep -qw "gl_sa95_casnav_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/604"
      fi

      ##################################################
      # DSDEN95/p/605  —  DESCO
      ##################################################

      if grep -qw "gl_sa95_desco_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/605"
      fi

      ##################################################
      # DSDEN95/p/606  —  DGRH
      ##################################################

      if grep -qw "gl_sa95_dgrh_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/606"
      fi

      ##################################################
      # DSDEN95/p/607  —  DIPER
      ##################################################

      if grep -qw "gl_sa95_diper_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/607"
      fi

      ##################################################
      # DSDEN95/p/608  —  DGI
      ##################################################

      if grep -qw "gl_sa95_dgi_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/608"
      fi

      ##################################################
      # DSDEN95/p/609  —  DDT
      ##################################################

      if grep -qw "gl_sa95_ddt_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/609"
      fi

      ##################################################
      # DSDEN95/p/610  —  SIE
      ##################################################

      if grep -qw "gl_sa95_sie_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/610"
      fi

      ##################################################
      # DSDEN95/p/611  —  SME
      ##################################################

      if grep -qw "gl_sa95_sme_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/611"
      fi

      ##################################################
      # DSDEN95/p/612  —  SSE
      ##################################################

      if grep -qw "gl_sa95_sse_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/612"
      fi

      ##################################################
      # DSDEN95/p/613  —  CGAB
      ##################################################

      if grep -qw "gl_sa95_cgab_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/613"
      fi

      ##################################################
      # DSDEN95/p/614  —  DPAH
      ##################################################

      if grep -qw "gl_sa95_dpah_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/614"
      fi

      ##################################################
      # DSDEN95/p/615  —  APAD
      ##################################################

      if grep -qw "gl_sa95_apad_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/615"
      fi

      ##################################################
      # DSDEN95/p/616  —  MLDS
      ##################################################

      if grep -qw "gl_sa95_mlds_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/616"
      fi

      ##################################################
      # DSDEN95/p/617  —  Action_CULTURELLE
      ##################################################

      if grep -qw "gl_sa95_ac_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/617"
      fi

      ##################################################
      # DSDEN95/p/618  —  PVS
      ##################################################

      if grep -qw "gl_sa95_pvs_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/618"
      fi

      ##################################################
      # DSDEN95/p/619  —  IENIO
      ##################################################

      if grep -qw "gl_sa95_ienio_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/619"
      fi

      ##################################################
      # DSDEN95/p/620  —  COMMUNICATION
      ##################################################

      if grep -qw "gl_sa95_communication_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/620"
      fi

      ##################################################
      # DSDEN95/p/621  —  SDJES95
      ##################################################

      if grep -qw "gl_sa95_sdjes95_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/621"
      fi

      ##################################################
      # DSDEN95/p/622  —  CDP-EPS
      ##################################################

      if grep -qw "gl_sa95_cpd-eps_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/622"
      fi

      ##################################################
      # RECTORAT/P/101  —  COMMUN DSI
      ##################################################

      if grep -qw "gl_rect_aperav_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/101"
      fi

      ##################################################
      # RECTORAT/P/102  —  COMMUN SAIA
      ##################################################

      if grep -qw "gl_rect_saia_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/102"
      fi

      ##################################################
      # RECTORAT/P/103  —  COMMUN DAREIC
      ##################################################

      if grep -qw "gl_rect_dareic_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/103"
      fi

      ##################################################
      # RECTORAT/P/104  —  COMMUN DEEP
      ##################################################

      if grep -qw "gl_rect_deep_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/104"
      fi

      ##################################################
      # RECTORAT/P/105  —  COMMUN MODERNISATION
      ##################################################

      if grep -qw "gl_rect_modernisation_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/105"
      fi

      ##################################################
      # RECTORAT/P/106  —  COMMUN SAPAP
      ##################################################

      if grep -qw "gl_rect_sarh_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/106"
      fi

      ##################################################
      # RECTORAT/P/107  —  COMMUN CAP
      ##################################################

      if grep -qw "gl_rect_cap_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/107"
      fi

      ##################################################
      # RECTORAT/P/108  —  COMMUN MACEE
      ##################################################

      if grep -qw "gl_rect_daet_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/108"
      fi

      ##################################################
      # RECTORAT/P/109  —  COMMUN DE
      ##################################################

      if grep -qw "gl_rect_de_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/109"
      fi

      ##################################################
      # RECTORAT/P/110  —  COMMUN DAPAOS
      ##################################################

      if grep -qw "gl_rect_dapaos_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/110"
      fi

      ##################################################
      # RECTORAT/P/111  —  COMMUN CASNAV
      ##################################################

      if grep -qw "gl_rect_casnav_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/111"
      fi

      ##################################################
      # RECTORAT/P/112  —  COMMUN PVS
      ##################################################

      if grep -qw "gl_rect_pvs_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/112"
      fi

      ##################################################
      # RECTORAT/P/113  —  COMMUN CMC
      ##################################################

      if grep -qw "gl_rect_cmc_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/113"
      fi

      ##################################################
      # RECTORAT/P/114  —  COMMUN SAIO
      ##################################################

      if grep -qw "gl_rect_saio_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/114"
      fi

      ##################################################
      # RECTORAT/P/115  —  COMMUN DALOG
      ##################################################

      if grep -qw "gl_rect_dalog_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/115"
      fi

      ##################################################
      # RECTORAT/P/116  —  COMMUN DESR
      ##################################################

      if grep -qw "gl_rect_desr_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/116"
      fi

      ##################################################
      # RECTORAT/P/117  —  COMMUN DPE
      ##################################################

      if grep -qw "gl_rect_dpe_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/117"
      fi

      ##################################################
      # RECTORAT/P/118  —  COMMUN SPM
      ##################################################

      if grep -qw "gl_rect_spm_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/118"
      fi

      ##################################################
      # RECTORAT/P/119  —  MAIPH
      ##################################################

      if grep -qw "gl_rect_dipp_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/119"
      fi

      ##################################################
      # RECTORAT/P/120  —  COMMUN DOS
      ##################################################

      if grep -qw "gl_rect_dos_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/120"
      fi

      ##################################################
      # RECTORAT/P/121  —  COMMUN ASH
      ##################################################

      if grep -qw "gl_rect_ash_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/121"
      fi

      ##################################################
      # RECTORAT/P/122  —  COMMUN MEDICAL
      ##################################################

      if grep -qw "gl_rect_medical_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/122"
      fi

      ##################################################
      # RECTORAT/P/123  —  COMMUN SMIS
      ##################################################

      if grep -qw "gl_rect_infirmier_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/123"
      fi

      ##################################################
      # RECTORAT/P/124  —  COMMUN SBCG
      ##################################################

      if grep -qw "gl_rect_sbcg_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/124"
      fi

      ##################################################
      # RECTORAT/P/125  —  COMMUN DACES
      ##################################################

      if grep -qw "gl_rect_daces_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/125"
      fi

      ##################################################
      # RECTORAT/P/126  —  COMMUN ACMO
      ##################################################

      if grep -qw "gl_rect_acmo_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/126"
      fi

      ##################################################
      # RECTORAT/P/127  —  COMMUN CABINET
      ##################################################

      if grep -qw "gl_rect_cabinet_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/127"
      fi

      ##################################################
      # RECTORAT/P/128  —  COMMUN SG
      ##################################################

      if grep -qw "gl_rect_sg_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/128"
      fi

      ##################################################
      # RECTORAT/P/129  —  COMMUN DAFPA
      ##################################################

      if grep -qw "gl_rect_dafpa_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/129"
      fi

      ##################################################
      # RECTORAT/P/130  —  COMMUN DSI
      ##################################################

      if grep -qw "gl_rect_dsi_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/130"
      fi

      ##################################################
      # RECTORAT/P/131  —  COMMUN DAIPA
      ##################################################

      if grep -qw "gl_rect_daipa_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/131"
      fi

      ##################################################
      # RECTORAT/P/132  —  COMMUN DAF
      ##################################################

      if grep -qw "gl_rect_daf_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/132"
      fi

      ##################################################
      # RECTORAT/P/133  —  COMMUN INSPECTION
      ##################################################

      if grep -qw "gl_rect_inspection_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/133"
      fi

      ##################################################
      # RECTORAT/P/134  —  COMMUN DAPEP
      ##################################################

      if grep -qw "gl_rect_dapep_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/134"
      fi

      ##################################################
      # RECTORAT/P/135  —  COMMUN COMMUNICATION
      ##################################################

      if grep -qw "gl_rect_com_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/135"
      fi

      ##################################################
      # RECTORAT/P/136  —  COMMUN DAAC
      ##################################################

      if grep -qw "gl_rect_daac_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/136"
      fi

      ##################################################
      # RECTORAT/P/137  —  COMMUN CAAEE
      ##################################################

      if grep -qw "gl_rect_caaee_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/137"
      fi

      ##################################################
      # RECTORAT/P/138  —  COMMUN SARH ATSS
      ##################################################

      if grep -qw "gl_rect_sarh_atss_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/138"
      fi

      ##################################################
      # RECTORAT/i  —  INTER-SERVICES
      ##################################################

      if grep -qw "gl_rect_interservices_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/i"
      fi

      ##################################################
      # RECTORAT/p/139  —  COMMUN SAR
      ##################################################

      if grep -qw "gl_rect_sar_rw" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/p/139"
      fi

      ##################################################
      # RECTORAT/s  —  SPECIFIQUES
      ##################################################

      if grep -qw "gl_rect_specifiques_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/s"
      fi

      ##################################################
      # dsden92/P/501  —  DIRECTION
      ##################################################

      if grep -qw "gl_sa92_direction_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/501"
      fi

      ##################################################
      # dsden92/P/502  —  CABINET
      ##################################################

      if grep -qw "gl_sa92_cabinet_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/502"
      fi

      ##################################################
      # dsden92/P/503  —  IENA
      ##################################################

      if grep -qw "gl_sa92_iena_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/503"
      fi

      ##################################################
      # dsden92/P/504  —  D1D
      ##################################################

      if grep -qw "gl_sa92_d1d_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/504"
      fi

      ##################################################
      # dsden92/P/505  —  LOGISTIQUE
      ##################################################

      if grep -qw "gl_sa92_logistique_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/505"
      fi

      ##################################################
      # dsden92/P/506  —  DOS
      ##################################################

      if grep -qw "gl_sa92_dos_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/506"
      fi

      ##################################################
      # dsden92/P/507  —  DRH
      ##################################################

      if grep -qw "gl_sa92_drh_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/507"
      fi

      ##################################################
      # dsden92/P/508  —  DVE
      ##################################################

      if grep -qw "gl_sa92_dve_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/508"
      fi

      ##################################################
      # dsden92/P/509  —  SYNDICAT
      ##################################################

      if grep -qw "gl_sa92_syndicat_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/509"
      fi

      ##################################################
      # dsden92/P/510  —  SG
      ##################################################

      if grep -qw "gl_sa92_sg_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/510"
      fi

      ##################################################
      # dsden92/P/511  —  SMIS 92
      ##################################################

      if grep -qw "gl_sa92_smis_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/511"
      fi

      ##################################################
      # dsden92/P/512  —  SERVICES DES PERSONNELS
      ##################################################

      if grep -qw "gl_sa92_sp_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/512"
      fi

      ##################################################
      # dsden92/P/513  —  IEN_IO
      ##################################################

      if grep -qw "gl_sa92_ien_io_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/513"
      fi

      ##################################################
      # dsden92/P/514  —  DBAS
      ##################################################

      if grep -qw "gl_sa92_dbas_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/514"
      fi

      ##################################################
      # dsden92/P/515  —  SDJES92
      ##################################################

      if grep -qw "gl_sa92_sdjes92_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/515"
      fi

      ##################################################
      # dsden92/P/516  —  ASH92
      ##################################################

      if grep -qw "gl_sa92_ash_92_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/P/516"
      fi

      ##################################################
      # dsden92/S  —  SPECIFIQUES92
      ##################################################

      if grep -qw "gl_sa92_s_r" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/dsden92/S"
      fi

      ##################################################
      # RECTORAT/F/COMMUN_FORMATEURS  —  COMMUN FORMATEURS (g1_formateurs OU gl_formation_formateurs)
      ##################################################

      if grep -qwE "g1_formateurs|gl_formation_formateurs" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/RECTORAT/F/COMMUN_FORMATEURS"
      fi

      ##################################################
      # scan/N/<utilisateur>  —  Numérisation (dossier personnel)
      ##################################################

      if grep -qw "gg_gpp_lecteur_n" <<< "$GROUPS"; then
        nautilus "smb://bureautique.in.ac-versailles.fr/scan/N/$USERNAME"
      fi
    '';

    mode = "0755";
  };

  ##################################################
  # Autostart GNOME global
  ##################################################

  environment.etc."xdg/autostart/mount-drives.desktop".text = ''
    [Desktop Entry]
    Name=Mount Drives
    Exec=/etc/mount-drives.sh
    Terminal=false
    Type=Application
    StartupNotify=false
    X-GNOME-Autostart-enabled=true
    X-GNOME-Autostart-Delay=20
  '';
}
