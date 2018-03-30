Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49bltE6zExVxWvvfurXOwTP1OIcJkwQMEFZXaVlO6H1YBwhWEVdTNnOLAgYakI+PNnufeMw
ARC-Seal: i=1; a=rsa-sha256; t=1522393763; cv=none;
        d=google.com; s=arc-20160816;
        b=n53MbuXGmEoW9VPKi3iyotJ8FAz5Om6sI+/atZvaIykvIl5DTrWdursPTrOO/wDlKj
         CDBsDAY67dyMJZbWEfXYh52cRALa3zEPIU13WIwWcciJhEcKtO7b7yFfG8eP2y0saFrC
         WQM4eDywvUFvZAewHVy8sv9l0P3YsDpZKEVROHgh/JafQss6+2h7rMLnmTQnv3St+XnJ
         wMUyWpq/ZUaV0ePGT49u4qEhAVlVEqJEkkm63EPowNKefJfmi5NaBn1OeH3tilINsU3X
         RJQX5PVd/CypUTHlXSxdduXjsx/HnB/uhorQ3Om1XKD0B0UzIXq4gASSDo+gPmWIb1+S
         TxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=z+fnvAPhEhymaI13Pj1BbddHrN0VjRpJi12AIAHNwpo=;
        b=w0U18jQBj+3M3M5bYkeZOl8uHUVtcnA7xv8uKHTiDFtG4104tSvtEDzNZDTVikOggy
         wGMfJBHWSIgDmtfhNsdWV+/Vvv/Vxq8lwNxUlaN9qDj22CBmQZMhvgP1FvZRYvociceD
         EjfUV62sf3ICpBUoDVWMAsbnMYm5ckqnx0UCBUV/ACBhvkCeW4RC3iAa2Svh0ZqXexDO
         7X3ws8v01Zha0WK9/DPkRXOxCemK37zn+Pq6+xT4BXGhJaDnZTq6raxC0g/RxlrZGMro
         dLh1Uzu/B7ueidxRl/EooRNGDPnhgsE+jEeeg70h22d44eGwUCjut9PpoTC5B2H2E950
         qJXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 29/76] staging: ks7010: Remove trailing _t from 'struct hostif_stop_request_t'.
Date: Fri, 30 Mar 2018 00:07:52 -0700
Message-Id: <20180330070842.25224-29-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:CpbVjJgplQVFgUM5N51vPn7Fn6hQOPQfWT7LIUPWw1nBk2dhcFO
 ZKSHbwQOpc6AaHbEU+cAvw681X/rhK+NUjsstAlLoiOVA0ArmroLixhOUgccunlOL1+w+CI
 UEXehKdCsNTeCLbNhwUcj0AnBFiANnQKYeBxw57q8nBUr6fKSE8/IDSeYS33NMDnux/i1RH
 qTSwvL3qbQWYr8DXT9m0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GDteopNC0Qc=:IPk9A4yLFU8ksyWoZbzIC+
 n7ya5yemqut8SgdEuT0vOZUI8B7pDHSDE3f9ezOs6HX4vBOiWw8s2rv3FHHO4qxmF8fPjsQhY
 O8mBCPNNaYVOUASDxHjODNxyRqKxYLiZ+nq6hhxGC0KGPToA/auw0F31zNtFsUwvTF3E5DRGA
 7QFTWLPXtmbjMaPADRu5zS/jH3PxxZ4sov58N6f2vGVBupF5Ix0x+nEM4/K4tnBHpzmsvrtKJ
 wBTzSEi3xfmUXkWuTCmWSSSSnhW6p9OlTSdrfX4YOm/1acdmUjKxl44Kel+T6I/vBJFfs/N7t
 m8S9rUlSBuYQwbOltzqjdY9EuUg6HvKMrBzhiEvlTO4yR68mGaWBz1o42+Agf6UHdH/uu3XcL
 nzNJ3VCQIB6tic5p3D4nBzpfQPCGSZQe70X/FUMvGfYnGSamHgkz+lKaob6ffq6Spxic+9oyX
 Jz8k3Vrc8KhnZ8N5MOgWl0IDvDWjwrBeMcDGUwX3BD+2NxrEUM7haiafeGy1KYvF1ZRLfOKHF
 OBy6fAOtuU6yv8DKpe8+XtIkVxt+EDIX5epwpdqCl9LwLhT8P1MyyFobQN0xXP17zW6rNYcb6
 LUrVLfa8K/EZvojv0Uo91Y3clwVM0gsN82SHpS2FrTme37dXmmewdsl+nX/8hK9DHtPt3lv1l
 TeXJJAJY9kabNPmu0kN3FOe6Mv4XOnC8+OMz1N7+ewZwyNgwxcuX4mtogDJgnle7/gekSaQj6
 0dKg35lxx8JQiPvVcAI+mVSdaWuqxrbLW5lqyw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345563708806924?=
X-GMAIL-MSGID: =?utf-8?q?1596345563708806924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_stop_request_t' with 'struct
hostif_stop_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 2 +-
 drivers/staging/ks7010/ks_hostif.c   | 2 +-
 drivers/staging/ks7010/ks_hostif.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a11ee1c..d083bf8d238e 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -950,7 +950,7 @@ static int ks7010_sdio_probe(struct sdio_func *func,
 /* send stop request to MAC */
 static int send_stop_request(struct sdio_func *func)
 {
-	struct hostif_stop_request_t *pp;
+	struct hostif_stop_request *pp;
 	struct ks_sdio_card *card;
 	size_t size;
 
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 27db9732d9c3..5c78f94e6f72 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1426,7 +1426,7 @@ void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 static
 void hostif_stop_request(struct ks_wlan_private *priv)
 {
-	struct hostif_stop_request_t *pp;
+	struct hostif_stop_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_STOP_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 7dba1f46da44..03e15fc591ea 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -326,7 +326,7 @@ struct hostif_connect_indication {
 	struct link_ap_info link_ap_info;
 } __packed;
 
-struct hostif_stop_request_t {
+struct hostif_stop_request {
 	struct hostif_hdr header;
 } __packed;
 
-- 
2.16.3
