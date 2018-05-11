Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AB8JxZrFWhnmpAM212rQilYo6deetuz+ePnFfdzCaygY3Qa1gM0sbxCCLg1O8pJBldkt1F9WxKe3
ARC-Seal: i=1; a=rsa-sha256; t=1526052532; cv=none;
        d=google.com; s=arc-20160816;
        b=zJRD7WSyudlTosCDBdrMPn4ce6fenAR8ZvsiXH+qakfvsi7IKx+gpEXMRSrxhTLJD6
         Pa+e+z4dqoMgqAL4m1BE9WxDAydcQDGFyc21tmy/cqhoXApVgCkUauddDjDzIM/lwQ5q
         gKBZx5rq+yATjZkRdzd17xfENf4qpUAx+jMroKH+Krw5J6lKw/vljsMCdNKlZYOBNqLz
         FiCYexw31ogzFPWqVTrK4cnM4phOTtl2PlOET87mrYyulEmEkf/xp6no6If3xMALKU3f
         WKLdbdQKiWWHCnlmCNv3e9xyq0xlo2Ugj3S7U7nKE7aVCRelZ3eTx6Wuy1kpBC8ueCtv
         SFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=BtJBcuFbMVGJDqwi093R3OU6YoXO3GY5QJTZZSf4VrE=;
        b=PBygX1nW2tf8JGqvzyoZSNnQZ7sSGANlhnlmzQCKzI+4+EoDhzRLn/hwzNQswutXlp
         CIIj++nzjeAUSdP9wn/S0Q9shxiwJH1DfklUoZu5gNqhsCfF2trvF4jc0rqettV3xDNS
         01GZ3bVovSkTWPz3kWFMVFVUZy4r23zw0Yza5AygPPfSLl3IshUZ8YUWJyjFrS5Wd6b9
         lSOuTMd/qAPFfHiCCwtmVBUZclx0Ex0DP5I7Ap0u2gGaXOgkTgFpah3NAiV0h4nTWLTC
         wfRuwXKDFWZxYwMqZ3Ux8BFCMLZXwQiXvdF74jqrfqSjWcbC9tDldwV2qLrBuLh9TMUc
         1ESA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=l8MFJ5N/;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=l8MFJ5N/;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Fri, 11 May 2018 08:28:48 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v1 0/7] platform/x86: Mellanox add fixes and new features
Message-ID: <20180511152848.GB6391@fury>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077324934314192?=
X-GMAIL-MSGID: =?utf-8?q?1600182060429272003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:02:00AM +0000, Vadim Pasternak wrote:
> This patcheset includes:
> 
> Document fixes for mlxreg-hotplug driver and mlxreg header file.
> 
> Fix for the race condition in mlxreg-hotplug driver.
> 
> Adding support for ODM system types.
> 
> Activation of Mellanox LED driver from mlx-platform.
> 
> Introduction of new mlxreg-io driver.
> 
> Activation of mlxreg-io driver from mlx-platform.

Patches 1,2 are queued up. Dropping 3-7 and reviewing them now from v2.

-- 
Darren Hart
VMware Open Source Technology Center
