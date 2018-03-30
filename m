Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49rNkSvaIxuwXf1B9pTB19lo0cF1NYAYgqFTfTU44kmz0ExiQ94ZL6rfX7KGEKIB1k1HFms
ARC-Seal: i=1; a=rsa-sha256; t=1522393763; cv=none;
        d=google.com; s=arc-20160816;
        b=ktB8I3n0T+oFVlCM9xLWphFNsyBIBWoqEWsBD6RRw5VOh3p6ImgK4DxrmnYVSMKVCZ
         7fGcTu1ICGn8Rk2IfkpoA020IJZB7xo/6YiJAkjhG9Z+T+FJQQPk5hcH6Udhf71GmciU
         NE0yKi21BJ2KIvJbnsHnZ/tAyT+HqSjas1JAJDGf7g536nlsjaBeGAp//iRze4b5P5OA
         iK3vSEnUmM88eVnG73H8T7KURo/ALLVLOC4VY284JIbj+mvqO76w9SPeXC1ZqFfEjqvZ
         EdmCoDHVxxh1RL5wXcxExrzBDj1/KFC3sRDSEHTXvRZhyR0L9zxnv8kzQ7PdgbK9q+ej
         8W0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=MsRCyEOH/zNJLyAq2+wtNDhQc4U6GFMVkt5x+jo9hGY=;
        b=ilqtliwhQTcY/DVKw95qzNnpiTctI/96cKF8fGRSoNrYupc09ooiQ1hmffk9OETING
         XcKlslSRS63s/jwV2pkIz/zg4kcx3qger1RVNFsQO9hKVQ6gjz+n6p3SsohpbKP1MGdC
         YeLC7nYfphw1fPMrA/zduKuQXrc8gJuxTiSBm6cJVO8WWg5KXUHmia5BIl8BuwB8X4Ae
         R1WthP3BbR+C4kLEhhuzWSjRQXaUalN1XumeV+jWuaKNoB9nWBMz7XseSNfFeF7S6CMb
         PDuewwZXE5C6GbsV7grqqEqMpvBK+OQH9Cbi9E8nfADRRoNLxG8DF0vlFEeKEDSSoCwa
         t5Zg==
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
Subject: [PATCH 28/76] staging: ks7010: Remove trailing _t from 'struct hostif_connect_indication_t'.
Date: Fri, 30 Mar 2018 00:07:51 -0700
Message-Id: <20180330070842.25224-28-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:2QvAUkHYwGoSgMUAotDiRNHuJHIvi7lswwogxQYHjW/kKvgeTz6
 pNKZ/TsqL1cR3frSYrZF8HeED0Pzlv/5vtZTjt8j2zc+l0kghBvYIt0v7nP/SHah5PxBtoM
 e2BYRd6Lfz5KvA8MukdcKZ2PEv+aRTYF1OuTDDm52JAXO3oPycI1HEiCgDVFs3NHovpqjcQ
 moyYu3TVVMue4Gkm186ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:POjr62+SSmA=:gd3Wo/24tOu0XxeUp05Ojw
 zHLi9h+AIeerpWHZjLwNx1Zp2OFTEGm2G3F9jS/CwKjY76ekd8dCcfz/KAKEDMMqC+AmnehIS
 8aNdAuHu9dpAcVM1XdyItdo5NpaEcv+1wchNvSQwhmOZaNa3ux/cGSxWyVSkg1Ck8RgnVVjnz
 5JoiwmsNKo6naFXdJK0DgDT+mEyTmxZDb2B8TxdhkGetq56zC4QwlkVvzbnwqNFlYo0mWISzb
 IAkae2gR/nkHYrb8Mm/VkYwGptIXpRSAGt1HIaL0GzrJ69zrNSWYEqRahjUwivdWmkY2/Xyol
 4JzMEQbV9RQQ1SVT1PWVSt9DbQeSFSaFnHxZy58swoXFvvSofGOJg/PUdyR8hrsuLnfOjQgQi
 qhVzABI/co3kYl5wJczKYQJ/BYSr4kTZLhl8vdcof+dNadKWR1uaMMsRIOnsj9NFuGMRP364E
 raxc4Q+DyvehXCGzyZJB42kV49xeFX76YIF1hO6/TJKYZMYmqkTOXyv2ka2iYhbE5EHuASNcA
 egSW3HdsPysWEr3OWlIFiIHelhnBaCTMhU6j+7zDHVydlyPicEMYPgYBQULWH7KaP8+Zsuk3N
 ij3fQNb+vJoXXlGlB9ZKzu0zgHMskJdhThnv4L/BgULJQwbgcweMPQjm3aV33oHixYou6ZpOx
 djgJeLygWA4Poc02So1eg0Yr4jVfDLp/+PX/S1bBfrV7ZGJg6g1my/aO06DXX51Qr3lYWK8LQ
 55sli1kTdX4WjcDUBwqOJGvhuL7SXe029U5rYQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345562726228097?=
X-GMAIL-MSGID: =?utf-8?q?1596345562726228097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_connect_indication_t' with 'struct
hostif_connect_indication'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 46b19ddd23a0..7dba1f46da44 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -318,7 +318,7 @@ struct link_ap_info {
 	} __packed rsn;
 } __packed;
 
-struct hostif_connect_indication_t {
+struct hostif_connect_indication {
 	struct hostif_hdr header;
 	__le16 connect_code;
 #define RESULT_CONNECT    0
-- 
2.16.3
