Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981363-2-15356067814016487498
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981362; b=OICLb2z8KZWAE3HO6gEAmbwJwHD3kbJ258ekk4g/GuCJtyOSuk
    HQG20DnxvLvZUJX/BtIAaCb1Oq06pPkzP6hnbERWmHOt6NjOVT3vlGmYKq8ig4Cb
    x4rmJO3Q7x0/u8ivmWVWL7TtTHmPzW9GxOhbC7btSZy8Ly296nEMSPJpQM/mt0fn
    w4abrkCGx0qx5pGfBFXgMPA5lkb4MxA6t9E6SGCRF+UnywF0Kns50K1SRyv2DWaI
    VA0crghrX0FIwAuoJbbWgdEYYK/fBxh7bIj352nkDL6pZJEQi6+HLPohyzxoDBwZ
    Avs6e/XLJ5qu0JTaQ5UQbD5y8GC7yzJzvbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981362; bh=dgyHe
    k++yEE3HR58I0owNhRA4Z87mg96bhpYMjbUU0M=; b=lBWl2FgcU3IPpxQRgeAPa
    Nwyd3XyJfuvknH+vBu4JebrN7W1SoCjgb/g13b3JvDjHR8aS94FO9PJFURinPNGE
    LRlZXVktPuzcuOT0oU99AAfeU9lNADDNb3EJWOlhUTrttpHF521g+0GN5ZKC4+80
    LszYKi8wS5x4SAo09hy88s6gty6g8rE1zaOm4RY2pp++/jFUkKa2psMoXL3otIw6
    ofRisaflKyY1xvfK/RA0IhXSEY3mSfeVTFopnE5Qe4C9C5mvQeH7ghnOaZ9hLLLa
    txz+eUDQBzjKgH+OwNz2uqcSIC6eLYeosQMLpzthVwOAxPD/61XfqU64HeMQOm/a
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPWihwZ9oaeSm96zB5EZpV+PiDFbCv5//uuRsbvRRt8D30bzvYndZz2/YovgLw0uuHXXINuXuzQ4Y/REEs36ZTw5Q6KCy3BwoZ9C1w6GRFWOWBnEFC7T
    q+XAtYIvEV5MgXIgh7FTPR/RD5E4xHpXoI5bN8EsIXvXFYy2fYA9nulE5LaWpxDcVvbucDiGsiGppsqgN2DQyEHmbFF09F9d/FDdBf56IfauuQ3u+nugnPUD
    AwsJxRkhpY5bhO87mR4s/A==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=aEcCyTWBCfbMP33nUj0A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 00/15] staging: bcm2835-camera probing and cleanup
Date: Thu, 10 May 2018 12:42:04 -0700
Message-Id: <20180510194220.30675-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
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
Cc: Eric Anholt <eric@anholt.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm going to try to get Dave Stevenson's new zero-copy v4l2 M2M codec
driver merged to staging (my primary motivation for getting vchi
merged in the first place!), and this series makes the camera driver
probe successfully (an important first step!) and brings in some of
his cleanup changes.  Also a couple of compiler warning fixes, for my
own sanity.

Apologies to those who saw the first two patches last night.  My
git-send-email-for-staging script was missing gregkh.

Dave Stevenson (10):
  staging: bcm2835-camera: Skip ISP pass to eliminate padding.
  staging: bcm2835-camera: Allocate context once per buffer
  staging: bcm2835-camera: Remove bulk_mutex as it is not required
  staging: bcm2835-camera: Match MMAL buffer count to V4L2.
  staging: bcm2835-camera: Remove V4L2/MMAL buffer remapping
  staging: bcm2835-camera: Add multiple include protection
  staging: bcm2835-camera: Move struct vchiq_mmal_rect
  staging: bcm2835-camera: Replace BUG_ON with return error
  staging: bcm2835-camera: Fix comment typos.
  staging: bcm2835-camera: Fix indentation of tables

Eric Anholt (5):
  staging/vc04_services: Register a platform device for the camera
    driver.
  staging/bcm2835-camera: Set ourselves up as a platform driver.
  staging: bcm2835-camera: Fix warnings about string ops on v4l2 uapi.
  staging: bcm2835: Remove dead code related to framerate.
  staging: bcm2835: Fix mmal_port_parameter_get() signed/unsigned
    warnings.

 .../staging/vc04_services/bcm2835-camera/TODO |  11 -
 .../bcm2835-camera/bcm2835-camera.c           | 396 ++++++++++--------
 .../bcm2835-camera/mmal-common.h              |   7 +
 .../bcm2835-camera/mmal-msg-port.h            |   2 +-
 .../bcm2835-camera/mmal-parameters.h          |  13 +
 .../vc04_services/bcm2835-camera/mmal-vchiq.c | 210 +++-------
 .../vc04_services/bcm2835-camera/mmal-vchiq.h |  15 +-
 .../interface/vchiq_arm/vchiq_arm.c           |   6 +
 8 files changed, 301 insertions(+), 359 deletions(-)

-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
