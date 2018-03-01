Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELs8rfQ2x3Zc+X/TFqT1Ja6UesGmjawGtdimJQpK31oAWJLE6UkNYDsTlhSSg0BSzd9XIGJ4
ARC-Seal: i=1; a=rsa-sha256; t=1519881585; cv=none;
        d=google.com; s=arc-20160816;
        b=d2NvQiX8tvP78Ex75sTb/Erc2o976zyFR5njUblHW66thO8bHvj2yvwAXDsw5mUuyc
         Rh5lZ95MX0WmgT4kR3vgvBYBcnvGvMddbGgOEc8Z8JXWF3ZnSthxX9oLs+7l9iRnds8j
         oiMHepn4j6Ip8kgXT3pn9iX9ICIGn3UbKMPYgrN/vWHiQSM8FiAh58nfxAi1aYljPFbQ
         P1824turaIL9iBpXIhz5sf2iAwc48IhSInCnCkBdkSfCq+XATdd0SHCtrZzgk8TjGNjx
         DwMgg81c3OTE2+wXWoLsi7ILFVBMZbN/xCCrS+XpeOhuc0BU8qenBT1QdZ+dPOnQS42P
         If7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=LspC+BWxFmNINweKPWYmC7Ko7L2wUeY1HKKO1DN3c8U=;
        b=xTm7eRBkJJAsSgeeUCW6Hhi4OsMYl3EuhZjMYhp+xnZF6evkoxXDA0fmQbukOrKp3I
         xUa9Qw96IEx1qRTuzw/3pH1Pq3Ea+k4J7PWwAkgLrs3E7cPyKvWtDacudDO8HoD5SJhj
         37lCOrQWfuo7PXGcjFLYlDt96fIQW323YSLv3OiykbjVyGEY7KI12h0p12ydFFdnt8gf
         oP5mHf/NGWcHazt26vFO8UrMQi6xOuD3XhYUtBrHkLZXNHOwB7rooJitUC1zMexzk53L
         rB6NjcoxcSA4qRAx7MLSixI5p2qeob9YMNt8oyxNvPegZuHNGV9m4OCd4/1pwDVaxBXn
         OfZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 4/5] staging: ks7010: Replace local capability constants with kernel constants.
Date: Wed, 28 Feb 2018 21:19:10 -0800
Message-Id: <20180301051911.1314-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301051911.1314-1-quytelda@tamalin.org>
References: <20180301051911.1314-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:4zZemH2+lEAHLPREn2krcEVrF5JFqZ7nvFi2LtvhxqwTYLAcNu9
 OsEcdsGZtErYgAZjnyAwPNF0FUq0SMS8PXz2YWFcjUhCG2DkBP04UgaZFDOXFaa9OtyNyjl
 3MDt2JAX31FuosWLtcFIGcngV4K6Mvk7jlzcdZCu9UjjN0y+Fd4lDVJK0eLASqn6dHZE5fk
 jNYFVdIo22JcsiF5+CTyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:layxr6/TS/Q=:5iDteNPMRU9o0ziQR9cvps
 PAdj3keY70wSOdbRxYd/SKahWEoybWgF6NiXly5A+nVswoZ05VLzpM7HmlLEuh3C/rAEFvhF5
 rulypfGU9MslHVIedfMLJR38tQJXhEP1cDkjJ+V/TYB7C5kDGZ1R5PXkTjdP7r5zBbPnVYdTS
 H/OE1Fx6UrDMET2fjhYPv5xDleM7fJOjkLxtYqCZOAaYhdgxgWH+6Zltxt7TRgyyk2HwVofSx
 Ty+xMmswBRecwbPiiTY9zCDiMHa89ut0Hncgl64h21QWLJiLT3vVbsREQX4OoPh+A92aQ9F39
 LcQlF3cNGzqPCCs7pbec1qwEbI2F3UyGKBHUM0VcW5M/+FqvJz8/7PDOT7eC4z3bNduHVUk89
 mz6qcifoozj9MJ7zWL5mOZVRaxtxIQgX2lV/cExEtIdUr41OyMbNP/+ErZTMM9hWNDEk++2Tp
 06q4jVz7IhNne/8Jt0u2wR5kNpDd+uo4G9duYhjS4dab7sggfekp5Ld0emqCWyzlbI5F8yCH9
 7Exmt5rxKVBaPkrrxVaP49vlc7uMS5UYPy3VCSWLZtu5+UwnTpNSmCV3kOSEQkJx7DjrySgu4
 h2cN9BAsjXGPACltNrR7QfiARsGW+jIjNl14aVA+qWvSLzgsFMc8ZL8KVb6y69smi8h1t7+wJ
 UZTrh0tCJP6KXooV8NUgcDaMFeZGKiGmAB547x1oftO5WkXu1K25R5JK7VuGJf44wqxJsQPBF
 VUhRqSB0hwMDALtAHyXJFG32ryRBJyb5e8mERg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593711354009280243?=
X-GMAIL-MSGID: =?utf-8?q?1593711354009280243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver defined constants BSS_CAP_* to represent WLAN capability
codes; however, these constants are already defined in the header
'linux/ieee80211.h' as WLAN_CAPABILITY_*.  This change removes the locally
defined constants and substitutes the kernel's constants.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Reviewed-by: Tobin C. Harding <me@tobin.cc>

---
 drivers/staging/ks7010/ks_hostif.c   |  8 ++++----
 drivers/staging/ks7010/ks_hostif.h   | 10 ----------
 drivers/staging/ks7010/ks_wlan_net.c |  6 +++---
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 4d11627a3d72..f425975fbcbc 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1386,14 +1386,14 @@ static __le16 ks_wlan_cap(struct ks_wlan_private *priv)
 	u16 capability = 0x0000;
 
 	if (priv->reg.preamble == SHORT_PREAMBLE) {
-		capability |= BSS_CAP_SHORT_PREAMBLE;
+		capability |= WLAN_CAPABILITY_SHORT_PREAMBLE;
 	}
 
-	capability &= ~(BSS_CAP_PBCC);	/* pbcc not support */
+	capability &= ~(WLAN_CAPABILITY_PBCC);	/* pbcc not support */
 
 	if (priv->reg.phy_type != D_11B_ONLY_MODE) {
-		capability |= BSS_CAP_SHORT_SLOT_TIME;
-		capability &= ~(BSS_CAP_DSSS_OFDM);
+		capability |= WLAN_CAPABILITY_SHORT_SLOT_TIME;
+		capability &= ~(WLAN_CAPABILITY_DSSS_OFDM);
 	}
 
 	return cpu_to_le16((uint16_t)capability);
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index b46aa94c0d48..8f08e1e58991 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -284,16 +284,6 @@ struct ap_info_t {
 	u8 pad0;	/* +09 */
 	__le16 beacon_period;	/* +10 */
 	__le16 capability;	/* +12 */
-#define BSS_CAP_ESS             BIT(0)
-#define BSS_CAP_IBSS            BIT(1)
-#define BSS_CAP_CF_POLABLE      BIT(2)
-#define BSS_CAP_CF_POLL_REQ     BIT(3)
-#define BSS_CAP_PRIVACY         BIT(4)
-#define BSS_CAP_SHORT_PREAMBLE  BIT(5)
-#define BSS_CAP_PBCC            BIT(6)
-#define BSS_CAP_CHANNEL_AGILITY BIT(7)
-#define BSS_CAP_SHORT_SLOT_TIME BIT(10)
-#define BSS_CAP_DSSS_OFDM       BIT(13)
 	u8 frame_type;	/* +14 */
 	u8 ch_info;	/* +15 */
 #define FRAME_TYPE_BEACON	0x80
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index e48c55769c94..91acf87ab8dd 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1366,8 +1366,8 @@ static inline char *ks_wlan_translate_scan(struct net_device *dev,
 	/* Add mode */
 	iwe.cmd = SIOCGIWMODE;
 	capabilities = ap->capability;
-	if (capabilities & (BSS_CAP_ESS | BSS_CAP_IBSS)) {
-		if (capabilities & BSS_CAP_ESS)
+	if (capabilities & (WLAN_CAPABILITY_ESS | WLAN_CAPABILITY_IBSS)) {
+		if (capabilities & WLAN_CAPABILITY_ESS)
 			iwe.u.mode = IW_MODE_INFRA;
 		else
 			iwe.u.mode = IW_MODE_ADHOC;
@@ -1396,7 +1396,7 @@ static inline char *ks_wlan_translate_scan(struct net_device *dev,
 
 	/* Add encryption capability */
 	iwe.cmd = SIOCGIWENCODE;
-	if (capabilities & BSS_CAP_PRIVACY)
+	if (capabilities & WLAN_CAPABILITY_PRIVACY)
 		iwe.u.data.flags = IW_ENCODE_ENABLED | IW_ENCODE_NOKEY;
 	else
 		iwe.u.data.flags = IW_ENCODE_DISABLED;
-- 
2.16.2
