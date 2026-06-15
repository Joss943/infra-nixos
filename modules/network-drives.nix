{ config, pkgs, lib, ... }:

{
  ##################################################
  # GVFS / GNOME Keyring
  ##################################################

  services.gvfs.enable = true;

  

  security.pam.services.login.enableGnomeKeyring = true;
  

  

  ##################################################
  # Packages
  ##################################################

  environment.systemPackages = with pkgs; [
    cifs-utils
    samba4Full
    keyutils

    gvfs
    dolphin
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
      # RACA/R  â€”  RÃ©gion ÃŽle-De-France
      ##################################################

      if grep -qw "gg_raca_lecteur_r" <<< "$GROUPS"; then
        dolphin "smb://ad-idf.in.region-academique-idf.fr/RACA/R"
      fi

      ##################################################
      # DSDEN78/DAFCO  â€”  DAFCO
      ##################################################

      if grep -qw "gl_200_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/DAFCO"
      fi

      ##################################################
      # DSDEN78/S  â€”  SPECIFIQUE78
      ##################################################

      if grep -qw "gl_sa78_s_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/S"
      fi

      ##################################################
      # DSDEN78/p/201  â€”  SDEI
      ##################################################

      if grep -qw "gl_sa78_sdei_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/201"
      fi

      ##################################################
      # DSDEN78/p/202  â€”  CELLULE_TICE
      ##################################################

      if grep -qw "gl_sa78_cellule_tice_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/202"
      fi

      ##################################################
      # DSDEN78/p/203  â€”  CIRCO_LE_CHESNAY
      ##################################################

      if grep -qw "gl_sa78_circo_le_chesnay_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/203"
      fi

      ##################################################
      # DSDEN78/p/204  â€”  CONTROLE_DE_GESTION
      ##################################################

      if grep -qw "gl_sa78_controle_de_gestion_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/204"
      fi

      ##################################################
      # DSDEN78/p/205  â€”  DIRECTION
      ##################################################

      if grep -qw "gl_sa78_direction_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/205"
      fi

      ##################################################
      # DSDEN78/p/206  â€”  DOS
      ##################################################

      if grep -qw "gl_sa78_dos_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/206"
      fi

      ##################################################
      # DSDEN78/p/207  â€”  DP
      ##################################################

      if grep -qw "gl_sa78_dp_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/207"
      fi

      ##################################################
      # DSDEN78/p/208  â€”  DRH
      ##################################################

      if grep -qw "gl_sa78_drh_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/208"
      fi

      ##################################################
      # DSDEN78/p/209  â€”  DVSCO
      ##################################################

      if grep -qw "gl_sa78_dvsco_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/209"
      fi

      ##################################################
      # DSDEN78/p/210  â€”  EPS
      ##################################################

      if grep -qw "gl_sa78_eps_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/210"
      fi

      ##################################################
      # DSDEN78/p/211  â€”  IENIO_MLDS
      ##################################################

      if grep -qw "gl_sa78_ienio_mlds_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/211"
      fi

      ##################################################
      # DSDEN78/p/212  â€”  DATCP
      ##################################################

      if grep -qw "gl_sa78_datcp_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/212"
      fi

      ##################################################
      # DSDEN78/p/213  â€”  SERVICE_INFIRMIERS_ET_SOCIAUX
      ##################################################

      if grep -qw "gl_sa78_service_infirmiers_et_sociaux_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/213"
      fi

      ##################################################
      # DSDEN78/p/214  â€”  SPSFE
      ##################################################

      if grep -qw "gl_sa78_spsfe_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/214"
      fi

      ##################################################
      # DSDEN78/p/215  â€”  SDJES78
      ##################################################

      if grep -qw "gl_sa78_sdjes78_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN78/p/215"
      fi

      ##################################################
      # DSDEN91/P/401  â€”  Cabinet
      ##################################################

      if grep -qw "gl_sa91_cabinet_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/401"
      fi

      ##################################################
      # DSDEN91/P/402  â€”  SG
      ##################################################

      if grep -qw "gl_sa91_sg_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/402"
      fi

      ##################################################
      # DSDEN91/P/403  â€”  IENA
      ##################################################

      if grep -qw "gl_sa91_iena_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/403"
      fi

      ##################################################
      # DSDEN91/P/404  â€”  SAB
      ##################################################

      if grep -qw "gl_sa91_sab_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/404"
      fi

      ##################################################
      # DSDEN91/P/405  â€”  DOS
      ##################################################

      if grep -qw "gl_sa91_dos_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/405"
      fi

      ##################################################
      # DSDEN91/P/406  â€”  DGRH
      ##################################################

      if grep -qw "gl_sa91_dgrh_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/406"
      fi

      ##################################################
      # DSDEN91/P/407  â€”  DIPER
      ##################################################

      if grep -qw "gl_sa91_diper_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/407"
      fi

      ##################################################
      # DSDEN91/P/408  â€”  DIPE
      ##################################################

      if grep -qw "gl_sa91_dipe_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/408"
      fi

      ##################################################
      # DSDEN91/P/409  â€”  DAR
      ##################################################

      if grep -qw "gl_sa91_dar_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/409"
      fi

      ##################################################
      # DSDEN91/P/410  â€”  Service Social Eleves
      ##################################################

      if grep -qw "gl_sa91_sce_social_eleves_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/410"
      fi

      ##################################################
      # DSDEN91/P/411  â€”  Service Sante Eleves
      ##################################################

      if grep -qw "gl_sa91_sce_sante_eleves_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/411"
      fi

      ##################################################
      # DSDEN91/P/412  â€”  Service Social Personnel
      ##################################################

      if grep -qw "gl_sa91_sce_social_personnel_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/412"
      fi

      ##################################################
      # DSDEN91/P/413  â€”  ASH
      ##################################################

      if grep -qw "gl_sa91_ash_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/413"
      fi

      ##################################################
      # DSDEN91/P/414  â€”  CASNAV
      ##################################################

      if grep -qw "gl_sa91_casnav_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/414"
      fi

      ##################################################
      # DSDEN91/P/415  â€”  PVS
      ##################################################

      if grep -qw "gl_sa91_pvs_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/415"
      fi

      ##################################################
      # DSDEN91/P/416  â€”  IENIO
      ##################################################

      if grep -qw "gl_sa91_ienio_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/416"
      fi

      ##################################################
      # DSDEN91/P/417  â€”  sante personnel 91
      ##################################################

      if grep -qw "gl_sa91_sce_sante_personnel_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/417"
      fi

      ##################################################
      # DSDEN91/P/418  â€”  PAIRE91
      ##################################################

      if grep -qw "gl_sa91_paire91_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/418"
      fi

      ##################################################
      # DSDEN91/P/419  â€”  CAEVJRM
      ##################################################

      if grep -qw "gl_sa91_caevjrm_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/419"
      fi

      ##################################################
      # DSDEN91/P/423  â€”  SDJES91
      ##################################################

      if grep -qw "gl_sa91_sdjes91_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/423"
      fi

      ##################################################
      # DSDEN91/P/424  â€”  DEI
      ##################################################

      if grep -qw "gl_sa91_dei_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/424"
      fi

      ##################################################
      # DSDEN91/P/425  â€”  DACP
      ##################################################

      if grep -qw "gl_sa91_dacp_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/P/425"
      fi

      ##################################################
      # DSDEN91/S  â€”  SPECIFIQUE91
      ##################################################

      if grep -qw "gl_sa91_s_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN91/S"
      fi

      ##################################################
      # DSDEN95/P/601  â€”  Direction
      ##################################################

      if grep -qw "gl_sa95_direction_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/P/601"
      fi

      ##################################################
      # DSDEN95/S  â€”  SPECIFIQUE95
      ##################################################

      if grep -qw "gl_sa95_s_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/S"
      fi

      ##################################################
      # DSDEN95/p/602  â€”  IENA
      ##################################################

      if grep -qw "gl_sa95_iena_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/602"
      fi

      ##################################################
      # DSDEN95/p/603  â€”  DMPP
      ##################################################

      if grep -qw "gl_sa95_dmpp_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/603"
      fi

      ##################################################
      # DSDEN95/p/604  â€”  CASNAV
      ##################################################

      if grep -qw "gl_sa95_casnav_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/604"
      fi

      ##################################################
      # DSDEN95/p/605  â€”  DESCO
      ##################################################

      if grep -qw "gl_sa95_desco_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/605"
      fi

      ##################################################
      # DSDEN95/p/606  â€”  DGRH
      ##################################################

      if grep -qw "gl_sa95_dgrh_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/606"
      fi

      ##################################################
      # DSDEN95/p/607  â€”  DIPER
      ##################################################

      if grep -qw "gl_sa95_diper_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/607"
      fi

      ##################################################
      # DSDEN95/p/608  â€”  DGI
      ##################################################

      if grep -qw "gl_sa95_dgi_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/608"
      fi

      ##################################################
      # DSDEN95/p/609  â€”  DDT
      ##################################################

      if grep -qw "gl_sa95_ddt_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/609"
      fi

      ##################################################
      # DSDEN95/p/610  â€”  SIE
      ##################################################

      if grep -qw "gl_sa95_sie_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/610"
      fi

      ##################################################
      # DSDEN95/p/611  â€”  SME
      ##################################################

      if grep -qw "gl_sa95_sme_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/611"
      fi

      ##################################################
      # DSDEN95/p/612  â€”  SSE
      ##################################################

      if grep -qw "gl_sa95_sse_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/612"
      fi

      ##################################################
      # DSDEN95/p/613  â€”  CGAB
      ##################################################

      if grep -qw "gl_sa95_cgab_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/613"
      fi

      ##################################################
      # DSDEN95/p/614  â€”  DPAH
      ##################################################

      if grep -qw "gl_sa95_dpah_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/614"
      fi

      ##################################################
      # DSDEN95/p/615  â€”  APAD
      ##################################################

      if grep -qw "gl_sa95_apad_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/615"
      fi

      ##################################################
      # DSDEN95/p/616  â€”  MLDS
      ##################################################

      if grep -qw "gl_sa95_mlds_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/616"
      fi

      ##################################################
      # DSDEN95/p/617  â€”  Action_CULTURELLE
      ##################################################

      if grep -qw "gl_sa95_ac_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/617"
      fi

      ##################################################
      # DSDEN95/p/618  â€”  PVS
      ##################################################

      if grep -qw "gl_sa95_pvs_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/618"
      fi

      ##################################################
      # DSDEN95/p/619  â€”  IENIO
      ##################################################

      if grep -qw "gl_sa95_ienio_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/619"
      fi

      ##################################################
      # DSDEN95/p/620  â€”  COMMUNICATION
      ##################################################

      if grep -qw "gl_sa95_communication_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/620"
      fi

      ##################################################
      # DSDEN95/p/621  â€”  SDJES95
      ##################################################

      if grep -qw "gl_sa95_sdjes95_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/621"
      fi

      ##################################################
      # DSDEN95/p/622  â€”  CDP-EPS
      ##################################################

      if grep -qw "gl_sa95_cpd-eps_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/DSDEN95/p/622"
      fi

      ##################################################
      # RECTORAT/P/101  â€”  COMMUN DSI
      ##################################################

      if grep -qw "gl_rect_aperav_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/101"
      fi

      ##################################################
      # RECTORAT/P/102  â€”  COMMUN SAIA
      ##################################################

      if grep -qw "gl_rect_saia_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/102"
      fi

      ##################################################
      # RECTORAT/P/103  â€”  COMMUN DAREIC
      ##################################################

      if grep -qw "gl_rect_dareic_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/103"
      fi

      ##################################################
      # RECTORAT/P/104  â€”  COMMUN DEEP
      ##################################################

      if grep -qw "gl_rect_deep_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/104"
      fi

      ##################################################
      # RECTORAT/P/105  â€”  COMMUN MODERNISATION
      ##################################################

      if grep -qw "gl_rect_modernisation_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/105"
      fi

      ##################################################
      # RECTORAT/P/106  â€”  COMMUN SAPAP
      ##################################################

      if grep -qw "gl_rect_sarh_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/106"
      fi

      ##################################################
      # RECTORAT/P/107  â€”  COMMUN CAP
      ##################################################

      if grep -qw "gl_rect_cap_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/107"
      fi

      ##################################################
      # RECTORAT/P/108  â€”  COMMUN MACEE
      ##################################################

      if grep -qw "gl_rect_daet_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/108"
      fi

      ##################################################
      # RECTORAT/P/109  â€”  COMMUN DE
      ##################################################

      if grep -qw "gl_rect_de_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/109"
      fi

      ##################################################
      # RECTORAT/P/110  â€”  COMMUN DAPAOS
      ##################################################

      if grep -qw "gl_rect_dapaos_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/110"
      fi

      ##################################################
      # RECTORAT/P/111  â€”  COMMUN CASNAV
      ##################################################

      if grep -qw "gl_rect_casnav_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/111"
      fi

      ##################################################
      # RECTORAT/P/112  â€”  COMMUN PVS
      ##################################################

      if grep -qw "gl_rect_pvs_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/112"
      fi

      ##################################################
      # RECTORAT/P/113  â€”  COMMUN CMC
      ##################################################

      if grep -qw "gl_rect_cmc_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/113"
      fi

      ##################################################
      # RECTORAT/P/114  â€”  COMMUN SAIO
      ##################################################

      if grep -qw "gl_rect_saio_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/114"
      fi

      ##################################################
      # RECTORAT/P/115  â€”  COMMUN DALOG
      ##################################################

      if grep -qw "gl_rect_dalog_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/115"
      fi

      ##################################################
      # RECTORAT/P/116  â€”  COMMUN DESR
      ##################################################

      if grep -qw "gl_rect_desr_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/116"
      fi

      ##################################################
      # RECTORAT/P/117  â€”  COMMUN DPE
      ##################################################

      if grep -qw "gl_rect_dpe_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/117"
      fi

      ##################################################
      # RECTORAT/P/118  â€”  COMMUN SPM
      ##################################################

      if grep -qw "gl_rect_spm_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/118"
      fi

      ##################################################
      # RECTORAT/P/119  â€”  MAIPH
      ##################################################

      if grep -qw "gl_rect_dipp_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/119"
      fi

      ##################################################
      # RECTORAT/P/120  â€”  COMMUN DOS
      ##################################################

      if grep -qw "gl_rect_dos_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/120"
      fi

      ##################################################
      # RECTORAT/P/121  â€”  COMMUN ASH
      ##################################################

      if grep -qw "gl_rect_ash_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/121"
      fi

      ##################################################
      # RECTORAT/P/122  â€”  COMMUN MEDICAL
      ##################################################

      if grep -qw "gl_rect_medical_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/122"
      fi

      ##################################################
      # RECTORAT/P/123  â€”  COMMUN SMIS
      ##################################################

      if grep -qw "gl_rect_infirmier_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/123"
      fi

      ##################################################
      # RECTORAT/P/124  â€”  COMMUN SBCG
      ##################################################

      if grep -qw "gl_rect_sbcg_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/124"
      fi

      ##################################################
      # RECTORAT/P/125  â€”  COMMUN DACES
      ##################################################

      if grep -qw "gl_rect_daces_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/125"
      fi

      ##################################################
      # RECTORAT/P/126  â€”  COMMUN ACMO
      ##################################################

      if grep -qw "gl_rect_acmo_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/126"
      fi

      ##################################################
      # RECTORAT/P/127  â€”  COMMUN CABINET
      ##################################################

      if grep -qw "gl_rect_cabinet_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/127"
      fi

      ##################################################
      # RECTORAT/P/128  â€”  COMMUN SG
      ##################################################

      if grep -qw "gl_rect_sg_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/128"
      fi

      ##################################################
      # RECTORAT/P/129  â€”  COMMUN DAFPA
      ##################################################

      if grep -qw "gl_rect_dafpa_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/129"
      fi

      ##################################################
      # RECTORAT/P/130  â€”  COMMUN DSI
      ##################################################

      if grep -qw "gl_rect_dsi_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/130"
      fi

      ##################################################
      # RECTORAT/P/131  â€”  COMMUN DAIPA
      ##################################################

      if grep -qw "gl_rect_daipa_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/131"
      fi

      ##################################################
      # RECTORAT/P/132  â€”  COMMUN DAF
      ##################################################

      if grep -qw "gl_rect_daf_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/132"
      fi

      ##################################################
      # RECTORAT/P/133  â€”  COMMUN INSPECTION
      ##################################################

      if grep -qw "gl_rect_inspection_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/133"
      fi

      ##################################################
      # RECTORAT/P/134  â€”  COMMUN DAPEP
      ##################################################

      if grep -qw "gl_rect_dapep_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/134"
      fi

      ##################################################
      # RECTORAT/P/135  â€”  COMMUN COMMUNICATION
      ##################################################

      if grep -qw "gl_rect_com_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/135"
      fi

      ##################################################
      # RECTORAT/P/136  â€”  COMMUN DAAC
      ##################################################

      if grep -qw "gl_rect_daac_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/136"
      fi

      ##################################################
      # RECTORAT/P/137  â€”  COMMUN CAAEE
      ##################################################

      if grep -qw "gl_rect_caaee_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/137"
      fi

      ##################################################
      # RECTORAT/P/138  â€”  COMMUN SARH ATSS
      ##################################################

      if grep -qw "gl_rect_sarh_atss_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/P/138"
      fi

      ##################################################
      # RECTORAT/i  â€”  INTER-SERVICES
      ##################################################

      if grep -qw "gl_rect_interservices_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/i"
      fi

      ##################################################
      # RECTORAT/p/139  â€”  COMMUN SAR
      ##################################################

      if grep -qw "gl_rect_sar_rw" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/p/139"
      fi

      ##################################################
      # RECTORAT/s  â€”  SPECIFIQUES
      ##################################################

      if grep -qw "gl_rect_specifiques_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/s"
      fi

      ##################################################
      # dsden92/P/501  â€”  DIRECTION
      ##################################################

      if grep -qw "gl_sa92_direction_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/501"
      fi

      ##################################################
      # dsden92/P/502  â€”  CABINET
      ##################################################

      if grep -qw "gl_sa92_cabinet_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/502"
      fi

      ##################################################
      # dsden92/P/503  â€”  IENA
      ##################################################

      if grep -qw "gl_sa92_iena_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/503"
      fi

      ##################################################
      # dsden92/P/504  â€”  D1D
      ##################################################

      if grep -qw "gl_sa92_d1d_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/504"
      fi

      ##################################################
      # dsden92/P/505  â€”  LOGISTIQUE
      ##################################################

      if grep -qw "gl_sa92_logistique_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/505"
      fi

      ##################################################
      # dsden92/P/506  â€”  DOS
      ##################################################

      if grep -qw "gl_sa92_dos_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/506"
      fi

      ##################################################
      # dsden92/P/507  â€”  DRH
      ##################################################

      if grep -qw "gl_sa92_drh_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/507"
      fi

      ##################################################
      # dsden92/P/508  â€”  DVE
      ##################################################

      if grep -qw "gl_sa92_dve_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/508"
      fi

      ##################################################
      # dsden92/P/509  â€”  SYNDICAT
      ##################################################

      if grep -qw "gl_sa92_syndicat_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/509"
      fi

      ##################################################
      # dsden92/P/510  â€”  SG
      ##################################################

      if grep -qw "gl_sa92_sg_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/510"
      fi

      ##################################################
      # dsden92/P/511  â€”  SMIS 92
      ##################################################

      if grep -qw "gl_sa92_smis_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/511"
      fi

      ##################################################
      # dsden92/P/512  â€”  SERVICES DES PERSONNELS
      ##################################################

      if grep -qw "gl_sa92_sp_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/512"
      fi

      ##################################################
      # dsden92/P/513  â€”  IEN_IO
      ##################################################

      if grep -qw "gl_sa92_ien_io_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/513"
      fi

      ##################################################
      # dsden92/P/514  â€”  DBAS
      ##################################################

      if grep -qw "gl_sa92_dbas_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/514"
      fi

      ##################################################
      # dsden92/P/515  â€”  SDJES92
      ##################################################

      if grep -qw "gl_sa92_sdjes92_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/515"
      fi

      ##################################################
      # dsden92/P/516  â€”  ASH92
      ##################################################

      if grep -qw "gl_sa92_ash_92_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/P/516"
      fi

      ##################################################
      # dsden92/S  â€”  SPECIFIQUES92
      ##################################################

      if grep -qw "gl_sa92_s_r" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/dsden92/S"
      fi

      ##################################################
      # RECTORAT/F/COMMUN_FORMATEURS  â€”  COMMUN FORMATEURS (g1_formateurs OU gl_formation_formateurs)
      ##################################################

      if grep -qwE "g1_formateurs|gl_formation_formateurs" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/RECTORAT/F/COMMUN_FORMATEURS"
      fi

      ##################################################
      # scan/N/<utilisateur>  â€”  NumÃ©risation (dossier personnel)
      ##################################################

      if grep -qw "gg_gpp_lecteur_n" <<< "$GROUPS"; then
        dolphin "smb://bureautique.in.ac-versailles.fr/scan/N/$USERNAME"
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
    X-KDE-autostart-after=panel
    
  '';
}

