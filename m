Return-Path: <michel.pollet@bp.renesas.com>
X-Google-Smtp-Source: AIpwx48gybclAuyulIWvh7dbCGUmX8OLnCmq5dqU4ZCZgUBhtRxwJFEu3erX530LJN1sYcVTh/YS
ARC-Seal: i=1; a=rsa-sha256; t=1523871600; cv=none;
        d=google.com; s=arc-20160816;
        b=vJU9r9fGUiZnI73oYD9PuB/4N2fyOi9HQEH0D0s6NRrPHTfpEDZPKXOOwj0wZBz1ft
         HXV1sjFD+ljArNqbiea0Ee4VHBjeOb5UEtyvdqNA1JQ9BCPvXdba0jZxoIJBni7T/zd5
         snc0xt2K5a1biIq9vhkSikqEepot6gvGNUsj3UYAZKTXhBV0KW9MbD9fB+jvToViD0N0
         vyrcrDPGswY12sS6RfqCwmLrKfm7ncoqLQ9h1iNMoHnPet7y+3QnWNkH4XbgZKLQl/J0
         90TIZ6zYBeBgCSrRO93ZYfFD0QMynbDGaSKU5KDkMrkF2zvJOsjXpNcOsG36BNQibRJy
         nwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=088kp3tKBNhd1t8O1wFHgQkrp61vGOWS2/+jGFRBbPQ=;
        b=H/npTW4X6HS4XwCG87yJIG4MKaRIXu4B0xKFL+NLM6vAuvrYHhTNdsw+K05HFC4MDA
         O8WvBAWORJxm+BEYzVfiExq9m4fD3qMR+Y5bXrSPCirgOGY58ZBQEHoWOZ0KHsmfZwIt
         pXdgNJBEScrm+8ocfv7BWrc+YqW4MdLTFByEK8nV+vZsqz3cRo2iR/bTS1LjwManeyWK
         pqsxWAwzIbBqQoD041d4+q4ZZzxSNkTQiMJMqg+SWUfpEgEpdaBE9T0qsQnN1kNjtaqQ
         v3o5g5mjy+8ZvvSKaYqgmHIVdnfDafh3mekWS7I5Eyw0/kuQPG9UHIS8jnBvcFphr/xg
         IdOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
X-IronPort-AV: E=Sophos;i="5.48,459,1517842800";
   d="scan'208";a="278331359"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
	buserror+upstream@gmail.com,
	Michel Pollet <michel.pollet@bp.renesas.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Carlo Caione <carlo@endlessm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajendra Nayak <rnayak@codeaurora.org>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Frank Rowand <frank.rowand@sony.com>,
	Juri Lelli <juri.lelli@arm.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC 1/3] dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
Date: Mon, 16 Apr 2018 10:34:57 +0100
Message-Id: <1523871304-48517-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597895187404291878?=
X-GMAIL-MSGID: =?utf-8?q?1597895187404291878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a special enable method for second CA8 of the Renesas RZ/N1D
(R9A06G032).

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 29e1dc5..b395d107 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -219,6 +219,7 @@ described below.
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
 			    "renesas,apmu"
+			    "renesas,r9a06g032-smp"
 			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
-- 
2.7.4
