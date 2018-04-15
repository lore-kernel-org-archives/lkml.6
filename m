Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-227791-1523792573-5-5225649613698841607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523792573; b=Wkr6xEArDXBJLcTK/td/cAfBBQOFaVGbXezS836ix2lfsJfZ4l
    5KVYN8k9pEJhPwc/J9fcAMPLMChNeB3/FAaQr7MZSPVMmzgGMsOXk5vYBe3tEx3w
    yhnY+ZGu84vOH7zvde/RjGGWzIfB+bY5h/nWFxQPuarI2+AvXMmd6aBWANDMPRLK
    mnFHWMqgw8vRXY9Y2KF3xZ6BVosMoMPgQWHkI/gwsqTxtCKC9wj7mFTW9ng3B0Vj
    e6dIhG5cMdH+gcxK8rEJOtIxdLKzXgdMDbhyR9ZxmueAb0FIXDjCfeO5VKU1D3OU
    7/ga/atrDNJQLUa/OFby2PQ/QWiuon8DXfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:subject:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523792573; bh=qdExZ
    SJ6zCJTWa/MSzsefajPk6DBw07644NxEwSOtmk=; b=w+YNOft2apTmP0ToFQy1e
    GbZbjYUsZi/Umsx2P1F5VQ6Iul3d9opA6scEBVfpFoFSvIUqchF2HmpZIqoF8pXi
    7c744Hd+WzKHJCPgQXZO0RlnxfcFBbUostUpF0GF9NQ+67TRc2KriSePDLUpPd1H
    iFcbIb8Y3Lcmr6JyBGvCVcliPtRC7R+WAMr8EzuqYKYvvu7IykfwcZY+8yTsFaPA
    Wp/fgILkjjZXX0ViBhb/qG0fGNLLhL2q9yXb3D70BNuIcaCcJrs3VAdipnuCcUKp
    m5DQgRxC1sA15ndCTNiCeYzqXE9MEDyP6klt1+vFNIxxwikeFvrb9vSK05PFSZXb
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJFkkddeRuBOvBdsLz7bWCAnvHX+5Np3ow55YIPEOjYYctLd3zFljUtEWCUXzL24guzkJOcnW0vElwDL6xqL/+OPYz+gIt/cB+sxAbpzZECu/Iy3MyOj
    TtKTdjDTPZY3d+kmEoIlSCl9b8MBjaEuPj2sOnbASURbJ9djdF389RCwX/EsnEfuAAGAHwnGHZPce1pzkWhQD0QZKmlvjZwFfNlRlsBi94OMjEmy9HfJpZ10
    MpoOEvlRiAR2uIPuQxVbOw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=fnZIgW3DOfvk0C5jckAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 15 Apr 2018 13:42:36 +0200
Message-Id: <20180415114236.3560-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.17.0
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] staging: pi433: use help in Kconfig description
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch warning:

  WARNING: prefer 'help' over '---help---' for new help texts

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
index 87c2ee192cca..c7340129dd4c 100644
--- a/drivers/staging/pi433/Kconfig
+++ b/drivers/staging/pi433/Kconfig
@@ -1,7 +1,7 @@
 config PI433
         tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
         depends on SPI
-        ---help---
+        help
           This option allows you to enable support for the radio module Pi433.
 
           Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
