Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+x09XU6E68VgiTlfXU1hBBk0ZZSwYsa0zL/kjvvo8eKoYHxzblaf4+RK9lJMXBarnroiZm
ARC-Seal: i=1; a=rsa-sha256; t=1522393789; cv=none;
        d=google.com; s=arc-20160816;
        b=TXaX3DdmiE6JooHv/d+HErtdVc0svLUMSZUSl/xb7Q1pnRkBrKzh8IIdQKqSexllUk
         OH8jqFDW9/jJRNbyJES3C/smi8s5zrh2c3ooUf+QvvaOv7VPUs1r3iH5EKIB9Q/l+Xhh
         /XKc/+hucHc6/67nTZLzc9RLGevmAIux4Vi4I3Ns63V9nBDTXfZIniVTt37M5K5988pn
         gQI0J0i9TyCxHy8ugsqeucXICXtH+yxYmYv3Rbk/WWs43hhEAaWIbUHt7k1d2hmq2mD6
         w8M926q4jrTf3P9vO21Pf8QRf1Z0xisyVGD3EQF0wu5I/C4p7+uXzdgca7kyAtrn/rjO
         ZKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nsrajgpEv51GAFaIv5HD+8cZGcJ8fQaZKgGjZSAGNvs=;
        b=JMsFs3sAEoZYq3DUSKli+EJED8sY0cAmzpeTLsYf8TKS9a7wmuw2wxsH7w3XDTIPxp
         FZ0ZCzjRgbqNMCcALEdbsz5+8SNJl3Xso+ogE6L0OX1CBYGW9uhOPIrsJ1DbfNByE4M9
         5kIPNvV8Gh+srrzYQregfk+w8WfUu5yui3rvN4/pcpW+IAFEYFCFCVwz0nR2yL/rCI5V
         QD94J2EsOxDETJ5c6eHEs1mtkmnB6dv47c5aDA3E+RnxaE6nfGSM0+m7hbzBFqxrpelq
         NGRkomN2kCXXdf+69GDOF3LpicaFoRY8EjoutPbcanjiE55Sa9Jeb4VQAaqm4OOKrhAs
         o4pw==
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
Subject: [PATCH 60/76] staging: ks7010: Remove trailing _t from 'struct scan_ext_t'.
Date: Fri, 30 Mar 2018 00:08:23 -0700
Message-Id: <20180330070842.25224-60-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:zfOBVLh4TRq2DFH30aRBIsxVocQFwqCE3L3ykkoSohcdCsgtfBX
 nvfVtX4t+O1xNqim2uOKAIfSgZIRBtTpanmDfRgjQTqAT64pDbPd60v+gGXBvgxaxa+miCj
 TCTZrCyJvyrWRwtJ4kV0g9WtxGaGg9DCmz26MD+FhWxhfn66+4kqzMAjoJ1p9e8Y0CeZkpD
 N1rDhJxi+OLLXSuSTulnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vunG0zTvy7M=:exBSMe6dqHCNURwEZNhK9S
 Ofx2F6KZXzmBC35pQZ/x0gnotdSJGcvGvs+pp17dWU0CKG2ekxXLKMpO4KdDacmvz7Jd8oVVi
 mjVN46O8yB4V3RK6MxsxzwKdD9Z3IptaEJd6l+CjryL5uybPnlLsEQmeOp0o1WEtxRPsc0n/6
 Vc4IxOhX+Eshdgw7pI5TWKWf+cFBvh1PemQI5WKVMBG8xg2hsTCY6o5NR7+fc/EJ7FtWiTPTe
 c7XNY2Vo2HjEV2EfYcMeEzaDsSB44igg22VCmQ/tHKxd9Ajf9q7eCJuT3w+cAhyXDGfDv+2JJ
 yWxqik2bWIEi2urNc9cidxqkI4EUJXDT7/oYd8X+N9dK7KzfxSBdOPB3h3WQC7D4y0Ce27xb5
 d/DcuxnK9wfLIp6xhqzbVlp4nUpRBlC8nyAvgrQ/SnPHSyT+AwMtB0olkS07JQd5/Sna4QV/N
 tsx3ZFVvNUDUB3vL6qbAlWs2CaI+9sQXkZpzs0RZqLpFzYLf9/w5TSP5R8mvkv/OWhqc7vRbh
 qtTXkmSkbtx9ZmFmKuzLwUou5HaeET3LFs3lBDYhujhN8r6anZhEQfky66HOBIVbHIs61ZhAx
 ibOGdMr6xu+I6ecGp2CER3Y4W/Qgt/w+N+cUWx4Dz616qBILHPbIIcg6i2CyQtH0Ey14OMREF
 BwkEmclbe7AUBI2wzMJTE1SuSZoHer5XN8Tq/OhL/w0jFtpTCg2FcldDwrnXwa08wf8f0AvnF
 gXeLhzuDrCpYjv9UpAAoq3WF2Amcq6qyHne1cususf9c01MGgpWmY8u+RvodfFOvMNRHWkFeO
 8G+RJpx5ACln0JY1eIf4vAUamddig0fy2BvnxqX34JDRaPXlRlFhjoJxEfpbrVjN3KSHdLZFP
 20L+tS72duUoTKhjY/pOzhgoKxKIgug7JTHQ4fPaACMYXD4lpGe/Sh2PdNIrEd
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345590415169153?=
X-GMAIL-MSGID: =?utf-8?q?1596345590415169153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct scan_ext_t' with 'struct scan_ext'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index d10ad152aa32..ece9950ba893 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -292,7 +292,7 @@ struct sleep_status {
 };
 
 /* WPA */
-struct scan_ext_t {
+struct scan_ext {
 	unsigned int flag;
 	char ssid[IW_ESSID_MAX_SIZE + 1];
 };
@@ -374,7 +374,7 @@ struct wpa_status_t {
 	int auth_alg;
 	int txkey;
 	struct wpa_key_t key[WPA_KEY_INDEX_MAX];
-	struct scan_ext_t scan_ext;
+	struct scan_ext scan_ext;
 	struct mic_failure_t mic_failure;
 };
 
-- 
2.16.3
