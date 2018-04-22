Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+LMAfahnudzdm8f3xJgBfT/bl4ObrmpjBFumCQ29PsVpm9plF3f0U2Ui05MT5qLSriJvz0
ARC-Seal: i=1; a=rsa-sha256; t=1524406195; cv=none;
        d=google.com; s=arc-20160816;
        b=YM7JC2torjgWgYZyZtFt3nj66UNTHATbXRlFCR3zP7cLayK6zQWCNEavxlZQYoinlI
         R5tLbGpcswpkZ45Wu6YqunWlCqp5Q+XSn3hwhg+UWIFxrDhWxyq+uDuFSH+BAyhYupSn
         bF1vDqbnOZKJnpl8T+xIe5CC4MXPUbZ03FuQbKXuYJDNmrkqBlv52kaNIjRqz/b11oT2
         43qKkBxpT0Fb+dHn6cUnSGssnxJIhuiFJSb0dpxHj/MqiVOuEw8BtJ7Cid+DkY+MdBwH
         TeleKpJV7xb5YPpThMP1qHwgjwx6/RxhFwj6RuEPKem0mQt4KhlAFwpP5+Zvf1M8UNlT
         l3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HgD3794xHu/zZh1HtmuADpirp0IQk92Lo8HB27NGJCE=;
        b=OEQnJEl3+V6uYcG7Mdm5gA0ITfmDCSlYW6Htio2MsRkMPuxkl7Uhs4mtAVn7Oh9I69
         BCk09qxciYAfIRUxC+2cYmj708J9ujKY1qVCN4q6pg15IVMAtTe7h1uqD1Nb9xHtaIg3
         GDqG0lwFjQlMWnemwHjssyYtQV/g3wl59jZMOoo31QOfUjmkdOn+8+qtc9RlPdkJ0N/Y
         T+uJFFpk9k12NUlAV0Dzq6OF43JBb0tgYR3Os5lgtMFkoCTkc6xZOLpv8b+GnCkMELEU
         hvbwvq21JB0IL6Lvpebskr3onxn97bAhwEEDHcLQHDH+pR7fb4ZAiMWMSsEOdt8g358o
         MxAA==
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
Subject: [PATCH 4.14 112/164] dt-bindings: clock: mediatek: add binding for fixed-factor clock axisel_d4
Date: Sun, 22 Apr 2018 15:52:59 +0200
Message-Id: <20180422135140.006855491@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455193613859396?=
X-GMAIL-MSGID: =?utf-8?q?1598455750269395254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
