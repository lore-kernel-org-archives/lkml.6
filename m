Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521227482; cv=none;
        d=google.com; s=arc-20160816;
        b=hA73MQIAj21bXs/iNOAdrYCBOvftd0xuYKtQzNmIlEwcMvjaDzweH97+u6h3iKkw8v
         zY1jzZ/5iv66E94nZkOXjialS60GzB9sNT35COeRyDCNCeSOe9ei+EfUoPg8HH1YXPPr
         9Cy28kMNZjOBVNd88i9JZtfewl707BO9Lpu+iVn1Mf+34rriFD1VUxZxlUBeKiloWZzg
         enNIlp3jbJn8SdcnQzJZhbxk6ZFJouCxFnqqLoiTuzQpUqxRMTPJMjkZpA0h4Vqglz0x
         +Wkiph867K+66wZvr8+9SaVnlzmxXDqYyjr4CWblqS4WzU9tv1HadfsPg3Z7nEnk2KL+
         9Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:from:cc:to:subject:autocrypt:content-transfer-encoding
         :mime-version:references:in-reply-to:date:dkim-signature
         :arc-authentication-results;
        bh=mWP7cTx9qh2VlR+2B+hMBp7MeLQ7YqSWehoE9eBpg4g=;
        b=j6DKdxjOAwtiHorkIoOe+OvdXvxAK0Akbzx8fEBjLAnsFWwTo0SjY9YyvVJtdN1DsC
         qSmu9HUWCDyE31GtZRGoxJDH6MD22ZtEjVLnxGTgsA3GRcL+f7AZjV6YYTKPm2VQ8VZy
         xAjwf4CDJ87QiB3PHOnZmqwXxQYPI4P11MUoH8vLhKylkzvCgSr+n9aEhXkTRla5Y5d/
         K43T0DspaqdXsck/0wAXlghnYC06kPYsb+wSFWpnaaMuIC+IIbv1oxgvwBA3mrkdcJyf
         Yxzu/W3nMKuK+j6Bx1InplQ9pDfpl3hDzG+lAIgMd5afPbW7KLIjsK1F5hLHVWNPI0m+
         y7WA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oGB7fQkM;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oGB7fQkM;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuGarzPr1GKJEdSZZ4GElPxr6mhoA2aGYwshqAaC2nEvcROmM1vzmD62MO8iIAUBs+ORyGMYA==
Date: Fri, 16 Mar 2018 12:11:15 -0700
In-Reply-To: <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com> <20180316172234.GA4212@lunn.ch> <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com> <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=mQGiBEjPuBIRBACW9MxSJU9fvEOCTn
 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
 uUuzv+GKZ6nsysJw==
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs link netdev->phydev
To: Grygorii Strashko <grygorii.strashko@ti.com>,Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>,netdev@vger.kernel.org,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,Sekhar Nori <nsekhar@ti.com>,linux-kernel@vger.kernel.org,linux-omap@vger.kernel.org
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595122628456002064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On March 16, 2018 11:42:21 AM PDT, Grygorii Strashko <grygorii=2Estrashko@t=
i=2Ecom> wrote:
>
>
>On 03/16/2018 12:34 PM, Florian Fainelli wrote:
>>=20
>>=20
>> On 03/16/2018 10:22 AM, Andrew Lunn wrote:
>>> On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
>>>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net
>PHYs per
>>>> one netdevice, as result such drivers will produce warning during
>system
>>>> boot and fail to connect second phy to netdevice when PHYLIB
>framework
>>>> will try to create sysfs link netdev->phydev for second PHY
>>>> in phy_attach_direct(), because sysfs link with the same name has
>been
>>>> created already for the first PHY=2E
>>>> As result, second CPSW external port will became unusable=2E
>>>> This issue was introduced by commits:
>>>> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for
>attached_dev/phydev"
>>>> a3995460491d ("net: phy: Relax error checking on
>sysfs_create_link()"
>>>
>>> I wonder if it would be better to add a flag to the phydev that
>>> indicates it is the second PHY connected to a MAC? Add a bit to
>>> phydrv->mdiodrv=2Eflags=2E If that bit is set, don't create the sysfs
>>> file=2E
>>=20
>> We could indeed do that, I am fine with Grygorii's approach though in
>> making the creation more silent and non fatal=2E
>
>The link phydev->netdev still can be created=2E And failure to create
>links
>is non fatal error in my opinion=2E=20

They should not be fatal I agree, but it's nice to know when you are doing=
 something wrong anyway=2E

>
>>=20
>>>
>>> For 99% of MAC drivers, having two PHYs is an error, so we want to
>aid
>>> debug by reporting the sysfs error=2E
>> That is true, either way is fine with me, really=2E
>>=20
>
>Error still will be reported, just not warning and it will be
>non-fatal=2E
>So, with this patch set it will be possible now to continue boot (NFS
>for example),
>connect to the system and gather logs=2E

The point Andrew is trying to make is that you address one particular fail=
ure in the PHY creation path when using > 1 PHY devices with a network devi=
ce=2E Using a flag would easily allow us to be more future proof with other=
 parts of PHYLIB  for your particular use case if that becomes necessary=2E=
 This gives you less incentive to fix this use case though=2E

--=20
Florian
