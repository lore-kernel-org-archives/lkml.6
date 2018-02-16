Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-28875-1518781527-3-2709675038437520362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='COM', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518781527; b=ipTFWgQP7dDsMhwtv4wHO2hJN7KQ6+xLBvBHM/ET/HKEWsL
    hcghqOz0l0/UKg3GPK8wURBCB1z0s/tUW/WTL57Ue9KLRdpqnrpyMpBe5P2Z6DBo
    A5ycaPqag/8LfChtnPZ25TqIQa6CSqa886v+j+YffrDj27HQziKuR8Dkqlap1S5A
    b1zgRvXCqFq9xnaQo/NSVZ89GreqN3mqCpyrgZD0SU+MMT2AjytNhM2fgq0s+E49
    rOC137j1BUu7oFKDA5nzeM5FRHSLRvOGMJ0dzh0p1Deg3W+YhAy3WKsY0/Ng9UuM
    9hDB3kEn7Z015/cLjFMXppWpnYUSdLD47s6NTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518781527; bh=2
    S6dCXphOsp2e6Xjul9N9me003O9DIvFSgHAirZ1UVQ=; b=dMVuoVRhtuRwhZDLW
    z3vWlIr2ziA8vjxYL7JPc/rF9/eILkZB0wo+APsnDTor+uuLa7bfrgeHofBgwfpC
    rFu3G1fqOvsOvd+Ny4fgUqy7tN5do6XT1QVQ75JOI4lpbc9q2ofSd7r1ymWUdBFI
    as43MCE/73OqcMkQ1u95yGn+yhuP9Vexw8j+QL2adKl7cwiHynTlX2FGTAdHc4RI
    Th2KAR/Et6j2jyu18hZmuHnb5lZ4Bzo5AxFiPew2qzEy8mF1IcH2o19tvsXjzfBr
    8MMkL/iNFS/bDJ+9WxyoQAayvAkkT0KoOa56ywLSry6cC5KIneUcFgsIbD4DuljO
    vHlxA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=aculab.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=aculab.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yash Omer' <yashomer0007@gmail.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] Staging: nvec: fix line should not end with a open
 parenthesis.
Thread-Topic: [PATCH] Staging: nvec: fix line should not end with a open
 parenthesis.
Thread-Index: AQHTpxqNx5zJcGoU9EybSXRCoznvPKOm5x/w
Date: Fri, 16 Feb 2018 11:39:51 +0000
Message-ID: <dddd86a92a424906a37a36df239fb975@AcuMS.aculab.com>
References: <20180216113634.12848-1-yashomer0007@gmail.com>
In-Reply-To: <20180216113634.12848-1-yashomer0007@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yash Omer
> Sent: 16 February 2018 11:37
> This patch fix line should not end with open parenthesis found by checkpatch.plscript.
> 
> Signed-off-by: Yash Omer <yashomer0007@gmail.com>
> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 52054a528723..39fb737543b5 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -383,8 +383,8 @@ static void nvec_request_master(struct work_struct *work)
>  		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
>  		spin_unlock_irqrestore(&nvec->tx_lock, flags);
>  		nvec_gpio_set_value(nvec, 0);
> -		err = wait_for_completion_interruptible_timeout(
> -				&nvec->ec_transfer, msecs_to_jiffies(5000));
> +		err = wait_for_completion_interruptible_timeout
> +			(&nvec->ec_transfer, msecs_to_jiffies(5000));

Ugg...
Isn't the correct fix to reduce the length of the function name?

	David

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
