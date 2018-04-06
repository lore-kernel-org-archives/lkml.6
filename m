Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+4+te8VoZfWVCjChcxaaEqIudBf4Jize1mocVuczhYHgT+d2yDTYQUizA4XOwAzjUkCRup
ARC-Seal: i=1; a=rsa-sha256; t=1523022001; cv=none;
        d=google.com; s=arc-20160816;
        b=RR93bDhv0cNNwbXeTd4GzRCpTrYixuzRVk7nB2LhbSQyO7hbhyGjoXV2obnfer+neQ
         ULP4/sMvlSy074YHdwwcBUM0qMJxAKAJxUdyoiDcbRqjRngfYQf3TmvJPnnuLeiFL/LA
         1AE69L/kVy+7bOvpUFcodELRDwcfwliMTKPtR1BpIhfXFCqR7no0xK0yrfL7r0lTDf8d
         dd897VlY7NUCVppAM5OZn5YoN0jEMWIEY1Kne2Zv2TwJ/jOEkmi7HMUxhqNAZbT5eSMp
         9zUzhON/vPmxDKK+E8F2WUhMaoErSqjJNZ+MYwC96U1nOiSwkdRfn6bv4TdTgQw6xKMt
         wlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wOITMwB6OsCcdytwl7kKYzqZchP6wt2omJUsXB+KWB0=;
        b=GaDppSoOuzaCs8qlIeRZRP7YyPweD2QqXa25ekNKfpSa3fUSFBfaQ7EliWXaCmBU99
         t8ylRGMQKboUHEdLDLPZ04weyA9OrwZomIRszQR7zflfHNWBZKGrXc5pS3TdU5hd6oQk
         fGA80dybGyKBmDMguNjuNBwLbxPvdcHQxvy4MeatieONFQY150atvsqU4R5RdZ3fhp4O
         QF0zMt/fCAsM/RCvoAjGIsM9yE6/k3oQks8eTDaAObTRxC29LdjgDYjonMJK+wygysKu
         r5egWs7Fjs5cJThMexInxT1ul7fbrOwtQJacnno8XDzBlenxh+Ey+GedbXvw+ipZ10ye
         hUJw==
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
Subject: [PATCH 4.14 61/67] ARM: dts: DRA76-EVM: Set powerhold property for tps65917
Date: Fri,  6 Apr 2018 15:24:31 +0200
Message-Id: <20180406084348.455878065@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004318066186412?=
X-GMAIL-MSGID: =?utf-8?q?1597004318066186412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
