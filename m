Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49kRrx6ByfeEJbX3+YNbkds1HnLLmZ+skyhhP4om4nwPXwYQb2d/YyRQI5lyIWQfr7Xr+Y6
ARC-Seal: i=1; a=rsa-sha256; t=1524406403; cv=none;
        d=google.com; s=arc-20160816;
        b=gKeMCF8l1i3RyhesEIGkdYsSyK1KQYfAZhjQrYuWaOfp+BhBO3mlgIbp3uRZ33XdAL
         HyO6gPcTPxxBnDldRNAL85g/6kUuYuXaM0OltKVsdIcasnfBq3B6MPlrA3lwd4kODYQ7
         yPe4puTQmPiIbGUjn1cFKeVAP32wce2MftrLcTZiJ/fIQ3ZMyIRtUPAZOXHGzIkemJ+d
         6zY4fzd9sK2bH67hrl4Tak8SkBzgjUqNrAg/5dcUWhZV97Nsd3V7xc3EPBRlkbg4lySw
         qeWr9Ahc78XiXZfi7dATSnJjXxh/rYMf5wOUGCkdAut+rdVluMN53qV7gvAlbVjhPk+f
         P4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bpsK0GzJp8zj98y3V/T8JMv0gNsL8xjICAeKm75n5OA=;
        b=0TVz/0Cqz6+alFbI45ifWml78tnsXV+a/dlbvfvw7QtVW4k3dhsbSZJwxYWI1t0NkD
         1EInrS6d3IG3dIJEu1624XYYl/OrLNsUF7WwjMflzVe75AO65LRmuyK1TEx32MV2gB+N
         zkBhHsXz753mfdSzbL18i1+ODny1g/rGCphOKk/ReeHh15KlHlXaBTKPpvP3jPyYawrY
         plSw+gAC3x1mTWP9B9T7QnCLQzoh47v2pw7e0iTXvogb7hRzQpq1Pl4riBS9zdNFUNBq
         ituEsB8kFGQjOEiEcrNrZPDxvctJchR2Gvxkojo7dMMrWHQ6F5mSgt6z31+ZQhIQWP7m
         KmRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.9 57/95] dt-bindings: clock: mediatek: add binding for fixed-factor clock axisel_d4
Date: Sun, 22 Apr 2018 15:53:26 +0200
Message-Id: <20180422135212.751499486@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455193613859396?=
X-GMAIL-MSGID: =?utf-8?q?1598455968512605492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit 55a5fcafe3a94e8a0777bb993d09107d362258d2 upstream.

Just add binding for a fixed-factor clock axisel_d4, which would be
referenced by PWM devices on MT7623 or MT2701 SoC.

Cc: stable@vger.kernel.org
Fixes: 1de9b21633d6 ("clk: mediatek: Add dt-bindings for MT2701 clocks")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/dt-bindings/clock/mt2701-clk.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -176,7 +176,8 @@
 #define CLK_TOP_AUD_EXT1			156
 #define CLK_TOP_AUD_EXT2			157
 #define CLK_TOP_NFI1X_PAD			158
-#define CLK_TOP_NR				159
+#define CLK_TOP_AXISEL_D4			159
+#define CLK_TOP_NR				160
 
 /* APMIXEDSYS */
 
