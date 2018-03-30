Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+xOfwpn6e4xhBVQHOhnOESxrxaAC8znSMNcNsiuYWuDNCiFMMyD0DmEvxAvAQ0l3R5F4kg
ARC-Seal: i=1; a=rsa-sha256; t=1522393757; cv=none;
        d=google.com; s=arc-20160816;
        b=nBGz9+b7Q1vjzmJS9MrxDEteAo9EXvXncwj15dfOeEUMZn+SXhwcxqlX21CGF0BAW7
         F68fdcEj0r3j4HWVLRQiXnomaL+ovLD3i7ZvQ8lkEaCkw3soco+cLGJxhoWlaa8/93eL
         Ghb7wtSz2Y+WDv9xEaTL4x/C+r7qR5bIlF5638l1BHr2JHatFD9MBktbyUVe1HDQKjzw
         8Vgm09JWO5dHgrpq8uKSAWqT2RCZMDG1PZjIoo4n7hn4/p1gjFivr0zTvPNeg3PVv/iF
         vHeSzBl0eMToy6RBP56hv+mOK3pwyq1RVMZNfp9IZiPP/1bw/UdN/iJOMvYeYVwlCGO3
         moRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=OhLawSYXjTaHReDXlBiCx8ZUbazwW9aU9oVfcUV3ECA=;
        b=cZLSkOOGTqMS73MtWDBp/gfB7ml4zCMhC+/GoNDIXEubXF/MNakv+NdzQL4Djwmoqk
         k5llRvvHVFRy18q9SFkKnb+16O+AO+slZTmAjLbqDNHPoT/e6kAGFU/UY60tno3hVynF
         NnwYnGQu6enduIKCn/PHZP9HsX1mVktAmoZ1340xSi/5nn//kEA6yciW0fAPzY2Ga3lc
         oiOhrlF0jrOHtCWdFQESx6HyFF+6D+I7OglmIJeJ8tDzApxyL7nRuCWqYOCFzT0nwtSh
         VUxIjxLOOlEkDpgBkQoab3BumhWdMRQKRh1qcziZJAQCN+0sA3ZtkbfnMdWRoqQ5golM
         tnfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 21/76] staging: ks7010: Remove trailing _t from 'struct cf_parms_t'.
Date: Fri, 30 Mar 2018 00:07:44 -0700
Message-Id: <20180330070842.25224-21-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:WVgUJOQm1esvZUlhWcbOv50bSgGV2RfQM8WnAKsYTmeJIMg/Ina
 GQE37Eo9B2c8F3cgMCb0Pmi4SAZduX7KgW13XNKGA43XADaNJUx0N2yVV2fqKhIcM/AdK20
 IjIT9QDODy9XYdEPsB7YpE+axRc+D0NtC31kxPq+1yZziWdzxQ/FHlY9XMlH2zqW18kvEVX
 2Fp9HDxpJnl3f9zjEt3Aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7QW5bbc90ME=:acrdBRLdMYq26wR8isZRuN
 leAMD3vVRG/1SvhqrFK6Sx50gGrQ09O8EL0mNRmIjzHLj+YP5ArH7JoBYNip9Q5L9ulb+8xKd
 8ZdZRpCLyyu3g2yQ34Fc5YbWEiSYZKm42DdqPFyrSmF/y7efjiIAeDEeT9HK7vQPG3wQpkD4Z
 2UbkqSUhEVcxO8jXEQez4fwsdttXZkbXHEkJ0dkVcRJ0GneGe++Spl6PuLq22DprH4tuUjDTW
 nNqV46rtP/Qt8fWmGhaYIDMHomo3VR/PxFDJCKG06OX/rs2imvSolP+BKwpgbtty9tgeBeKDI
 vsUH9wRznXwryGaWOwVZkBqKpKHPDpMC2hUbzZViW5CSAyPEdN/NdCCTcl9DYA3SIl217vQQr
 Z2apqSP6AhEWS1d1WVDPqVihu5Pdg6EWHRxywUZPi4K4ta8PQK3JMqTSbWj70U8nJF5ge3CSo
 u6z9t7u+J/JWlJ3w+mxOjhPd6Ze9Vq6cfqfzanrIkDyh6TD/aiXtCNpaV6GwC1/9EwuLSXmho
 Eehv0NO+mJ2OwXJZltFywLL7q3khBUpgO9z34LZNl2KfCAmFY+ixuh7A4/EDv7rpYQ5hfIbcu
 vAtvC4EUeXjzIRafFjBro8SLjc2505btV3QSqonlgtYJtI1MVg9p/z10r6EP8ZmUGNc6mv3rB
 8ONPuBI0jsfKhVgccbdj4W/pFsxKejy9+My8OxSZ8qAnjIUneYiFV+0N1kPrZeS9AvVm7JdeN
 jvTgP4yek/w1HOwK/K5TOA9QUprPBVFDVNhuBA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345556125398613?=
X-GMAIL-MSGID: =?utf-8?q?1596345556125398613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct cf_parms_t' with 'struct cf_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 669453b707ea..f4e7500c07db 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -249,7 +249,7 @@ struct ds_parms {
 	u8 channel;
 } __packed;
 
-struct cf_parms_t {
+struct cf_parms {
 	u8 count;
 	u8 period;
 	__le16 max_duration;
@@ -302,7 +302,7 @@ struct link_ap_info_t {
 	struct rate_set8 rate_set;	/* +14 */
 	struct fh_parms fh_parameter;	/* +24 */
 	struct ds_parms ds_parameter;	/* +29 */
-	struct cf_parms_t cf_parameter;	/* +30 */
+	struct cf_parms cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
-- 
2.16.3
