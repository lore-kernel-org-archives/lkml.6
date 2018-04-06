Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49K2Gvi+bo2INqZdOrR08QoWWPZ2aEu9yLaB5Ui4ahwgDX7u+WR+1U7Wazzz1nq9jaamDgr
ARC-Seal: i=1; a=rsa-sha256; t=1523022211; cv=none;
        d=google.com; s=arc-20160816;
        b=KAX1O+et5lPWSTnzffs6u4Y1m1GQ4A66pFVSzI5b3HG62e8H5jgBwqr+yYB1pP9bhn
         YOYmHjxKrcJGefzOYYtO3Glc3zv1CZRpdYIjwGmnDX/uJwRYcVnpfFKvJ4Z+IYctim0H
         wCWP80Kr5v81bOTsXzIpiTIvkkmFXvZGKmwlzj8uFFO6cNTaN4U5vLg/dQL0hVi03V+y
         UwAbg1L9LG+sl+3v7nWeo9YhiBrSBg4bZJaoxjkYdLCsbiXlPz6d5WBBMnk8ZjuSUlDW
         A+wt+dpOc+a9+RHdmrqQfdI18h+3pq4G578jJZ3CpmfUKa6Kpi+jo1F6zc9GyKj4qbLa
         aO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VtHOxyc1kLmzuT4zxpEsup+TVBHrSFCrAyhxog2piSA=;
        b=ervF7eRIDgNxVrQ6hPslfeSzyOu6PhRsDPypVazmw0AHcEOOMi9ezF+rHhycFxWBNO
         0FyjxK1sKW5gX+wIqEG0jghMq2JG0FzDViqw9cGyYAJ8Dq3VBA5uxjQzlWvpGnJN6zeb
         JBLhVkt8ilZjYiFDgEpG8InTbXfupPT0d1zLwENHQjHzq0MWqRSwtjeFGtVhxh97wIc0
         rHOafJPiX7uRrMVzoc+31RcujIBzEW1+QwGTyO76xAF48ClmV8ElClPGHaoyodpOu54e
         /4bfvqeP1fGCJTd1gXQowQSrMwyz8o/Xz0yINPXOn1rWoNN+Y0IJtFPqk6vnBXK9booO
         bajQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.15 66/72] ARM: dts: DRA76-EVM: Set powerhold property for tps65917
Date: Fri,  6 Apr 2018 15:24:41 +0200
Message-Id: <20180406084353.833627663@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004318066186412?=
X-GMAIL-MSGID: =?utf-8?q?1597004538750863490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit aac4619d028e2c444ac1217fc2d05b0322079dff upstream.

Set powerhold property for tps65917

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/dra76-evm.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -148,6 +148,7 @@
 		compatible = "ti,tps65917";
 		reg = <0x58>;
 		ti,system-power-controller;
+		ti,palmas-override-powerhold;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
