Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+rcS/wOPmle5yNMrFETlC66H+SYlfxs8c5y9W0T4B2yTqMWL/nAGRyl9Gpp8wHVUM+ksEL
ARC-Seal: i=1; a=rsa-sha256; t=1522393778; cv=none;
        d=google.com; s=arc-20160816;
        b=RJWwA5NEed6UdIxNYqsB2AQtbgBTgvp+sVh+5ibQnu6Y32ns5uYD8ETHkGhv82ZvDE
         5Ko57JCoP2FgAT7c4HYv2yRQb+6/lAaBhTF+BzudS4edoNprJmC3cU41+EujYCCf2Jc6
         Hq6jDSD6WiI7RAttYRtF8H8JRm1PPQfHrLj1PhPcNGrAubuNqcVCwuhi8IDu13XE7aZz
         ICrK5cBHTSeiFd+rHY5/46k3Re33CGd8Ot9RCoP+Wt6euiveyHWoFRcfNuxvMh9V5407
         ptMN2kq1VIEPc13IrGcdCQaTOhBfM7x95IG2SDwc1jbl/VKneOOqob7LTmquYGy6nVBC
         bxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FHOXWQ62JEdybHLqQCzbkvGzDZ7vq6dLdtM4v5b1/sA=;
        b=Wj72f53CuffniJhKOdAQfoAr9MfudX3uBNvS8XJWfDVAuQAY/cWJFyVS0N/WaOL0Pc
         mW4AQ4+eLB7P3i63NoZrjfLSL2IAn69ixFcM1JXixiwtxWyZrulxd2OHHTw+IQGkWg0/
         66QPQyA7UMhN7lz7uZs9+9/T6epdQUvm/MBCi46rTu667axOlfILibEFeVG1gJvJvh1B
         4R0SdKm1c7fMXuzWrYvZoWuA4quq2i9IvX3zrj8YO0WK1zg3oq7PSOP6ZAnDcDDQtSM3
         n0l8t0hGL1IR9gNhmjABWWB4RH/BDBKq66i8F4tZvf85usGGzSaZfpAS0H1xjrW9dkKQ
         YuvQ==
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
Subject: [PATCH 46/76] staging: ks7010: Remove trailing _t from 'struct hostif_phy_information_confirm_t'.
Date: Fri, 30 Mar 2018 00:08:09 -0700
Message-Id: <20180330070842.25224-46-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Qrncw/hBcilVfGNDwFgKeewbLlxP5HuJdMaP9/B93581MAKyO7I
 r0hBTqhOgjXUZoP76OSPhmNhyHS8vxej2pBYJgX/fQp5LvZL0AWga7TjKSoGmO9A0EIIobN
 lroms/LWCC25+vvi3T9CENVNwOd+MbbIrqSUrmD6Txqy1iblJ7cya+5VwolozK4admP9rK9
 yGAriKqmKwiSlWX3gmlKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R9s4N6ER088=:FTqD0BK9IBbeslqtfNWmV4
 2vtUeM/8dwgzPOtse5tWEctrl+hhOF5C5wyVZtafwnwxgXCOUGmfWHZIzgbiK6hgW85WwBlwK
 agTknuvzLT1iVutrOxEFNSgeeyB6JpQkL4xHhldYrH8GJ2h+QhQH57cDidtFKhURO84+0VY6n
 Tx1Nu/x7QYTRzKXvswJCO9+UURM6KzBu1rHOIgoBabQudglDxlN1XyvXOHn7lmb3ads/0eKXd
 fLNQDSLjvi7Z8+Zgc9mSC6KVPvWaS/zYRqG1V5Z0DUxf4+sHIMdhJHgyliLsAsiCGeSUEZioF
 QCychmk+ZJ/VicKqVWnlCioSSSyYXCxxZDtpGAE7+Rnhq1w4m9An7pvrt/9keEk8ZU5RrlDjD
 PdB3QvV0uPmhisi4wcPUbEUbrd9k23PNLxWwZAiW4PaCSHQVVV9CVgNPcCyYtPsJbIZwijRXz
 abPG+1zOtjIbv8urMQwwRS5aTL/D582nkLOI0sfKeljX9+hlAErbuonH72aL2P/cYFw4uwYzF
 5RrcDvNYjPNq+W/NHzBbamD1njKCamlbS8y+mcPijW892vxIFI+ucZYhz+JvNRtWe3/L1/vRG
 uPVCfCCRBbPvMI/uih1/ugxRghml+JOlNoVB8o2dxBzuo0w1Mtns5nfN7kb3D/eG9021TKYOW
 vv8CDL6tn1+hnh6U/7w0Pz0tX5U73lf54/5tTPajSqkWA2TLWMVfEmW8WWJMu2eb+Iq4wL10d
 ys/c43NqTfU1XUUeT35tax8hPD9T+vZ6tLgdqU/lwQ97byRTJcTp9BM+OLhe5HeyzixrsTLt/
 1l8PHuBhXjPCLm7NgmuiCvbfZKxy6fXHPQ5suqGyiGnCSG+yy10v8HjIjCN4aJuiYx1zZjcoB
 Q1g3pyzWDhklR2svr2c/plR1yX2iqZXDQAeFt3Du3cXAsIJw6YdNGu4tdd1MZi
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345578753900422?=
X-GMAIL-MSGID: =?utf-8?q?1596345578753900422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_phy_information_confirm_t' with 'struct
hostif_phy_information_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 831c02d6e791..f6b4b3eecf2b 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -486,7 +486,7 @@ struct hostif_phy_information_request {
 	__le16 time;	/* unit 100ms */
 } __packed;
 
-struct hostif_phy_information_confirm_t {
+struct hostif_phy_information_confirm {
 	struct hostif_hdr header;
 	u8 rssi;
 	u8 sq;
-- 
2.16.3
