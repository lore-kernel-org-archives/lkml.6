Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-750150-1517655484-2-16241662536270967442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517655483; b=BKtvdwh/CFRud1W7JCr528nsjFnzAY3xTBd1eL9cF459lS9
    ECAIBHOHiqMKTuEZFkB0/xRMcwOYwD9SsRDZyiOwmWj4jyg1rD8IrD5BtGWnXCR1
    W5nFuueelHjxIcuU1l3srcN3Df1jwbmhy3Repa63V/CFZPwdQQ9ITTTQGaTCXN5g
    N5SmuAlhHTlZevC1chZpgxNc0qgPix6HVW1Om6lPwUujU5WkBueGnaDh9O1CXkki
    giSp+uC47BpcUXTbevf8GH+zBYYh5D3LkcCDwabAPmvLl5Kcwqu9QBCJtdCiZkx/
    ywzraa97ET/UP9BgauPiysq89XOvuzmCXiEWB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:subject:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517655483; bh=h
    B/cDbMGluoQF5fQnfPDfXiKpEv9MxUEfQ4xtq3267A=; b=Ssc/4yN2xX0p9EiP0
    52O4+H/ZKmlsbet+QyS1V783oC5HWDeqx3JZamA2uwVf3mBUnQA8Tb/DbRP6DQEb
    w7/vkdpeinPgB9OykBe/a7h3JiNO5JWdVbdUFLvRs6jidgwmme6bELZPUeuBaL2+
    ohf40XT9cpcgQdZhD2LaWBBqh4pKTC/H9RaDPpYksl5PGWXn1CB1DYCdoQFDJ8fS
    aywS6kUFx6asiyLdtYBux1BvWuWygmOLyuss5U+AjxT0sjRxrb7oR6FRjC03kHFW
    cS0Ambi8u+vA2kQCngY5uAnl+eEQQqetuCROIP3wDWkYJ5GHE6kXdoJnOCWSOHFm
    cjxKA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=i2se.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=i2se.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 3 Feb 2018 11:57:31 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Corentin Labbe <clabbe@baylibre.com>, eric@anholt.net,
 gregkh@linuxfoundation.org
Message-ID: <131618745.47691.1517655451980@email.1und1.de>
In-Reply-To: <1517517543-34957-1-git-send-email-clabbe@baylibre.com>
References: <1517517543-34957-1-git-send-email-clabbe@baylibre.com>
Subject: Re: [PATCH] staging: vc04_services: remove unused files
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev21
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:lwOdgxZz9PafGrAS/0/1IbLWelJqHcou1WbY800S6okh9xMbacv
 hvhtefbK2SnfyGsBTaal40uuhlyxc8StdPa4nQxHyeAV6f81TdbcEyMBvR+y6yYPCz+IBGH
 m3CDbMssfQh395sAPm4IbZf0SR6Qw2NgiCGnPFTRrIGD+QNeFh1tH2q3SvrHxeJLagm7Ijz
 6yf/LFZ++tbU6OJ5nQk2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3tLEtb27fV4=:aL9pcXdvQukUl7knnHRPPj
 ImE6qiZ/PQz6XJ4eDZQWxiAJMJt+sCzzie3aYd9iN7GRiMibELrARn2z++bTPFvR/UAgU61PD
 MEeN8dGteDDKnVpWxYbjKdujb7oXuRtNxmdDusl4W2mJfNBxmtcCzePwRTx7OkiBX/GhjThAB
 z+kdzMn/ieH6Q8dyn8xaNmZyZp0BwKbTK/7bq4fxIBvoaZZvFDem1Xvp/G7qHSxvBvNgarzfH
 IH6S42mA9eX4deyQsw/NHaM+AuOeCW3b2OM5njgEPt4RelkxoSYzmPL8yxQ4auZOdyj0jAnAj
 qEpU5y3IQQ+I9/o7ej61LoZrWkLHIOEgSthPMPz3TB/WE/eq1hgMrk8cTFaRBFPD267ZlS18o
 0CQ2ulo/vWAuCYD69uzN8npy8ypOgcqIeg2e14ZYEpK6hLqScmzebLNBf4kFO241jiqCRg0r6
 wNs2oYvlSYkRkfLQvtrEEJ24qiHzY9NqBvv2BjOYcM83vJI/KhP0CQgcBWXW2V5Edagd9X/Jo
 mDoxlOtH7pU3INHnoXtzKObM8AVo3L0mbfkWMywX5RisHRFX1/3HEH5TzH2OCgTe8uCZy28Vn
 9hIrYw7oRvwwutlaIR6xeldTbisxL3HprgbpGM+8qur07T+50R4CYI96TMT5P0Jw6AkRh7/OO
 Qm5qMN0RFHoYJK41L9F0hji8qBJJIkju0/MPbx/YNiCUbwlIfkmu1n70eB1qglCrSX3xnLzka
 KBmvixeKb5SHwMLqTTjGR6r2zgpIVMmtOYYvTdx0B83/J7/ffDPrJqA/jC8=
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Corentin Labbe <clabbe@baylibre.com> hat am 1. Februar 2018 um 21:39 geschrieben:
> 
> 
> All thoses files are not used by anybody.
> Lets just remove them.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../interface/vchiq_arm/vchiq_build_info.h         | 37 --------------
>  .../interface/vchiq_arm/vchiq_memdrv.h             | 59 ----------------------
>  .../interface/vchiq_arm/vchiq_version.c            | 59 ----------------------
>  3 files changed, 155 deletions(-)
>  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_build_info.h
>  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_memdrv.h
>  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_version.c
> 

The memdrv interface is possibly used by a driver in the RPi Foundation tree, but i don't see any need to upstream it.

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
