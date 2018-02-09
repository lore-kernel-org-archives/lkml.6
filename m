Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AH8x224czt/pRWJuXvTTozaDT7Td4RecBAJIfZjETuSCYdd07BtxOuy1eGRTm7k+Z9gjRhIIrbR9
ARC-Seal: i=1; a=rsa-sha256; t=1518142882; cv=none;
        d=google.com; s=arc-20160816;
        b=Pn80VmBVON4S/eNP8qcuhfJ3WnelvgW093+NhZCmEADaUQ1S9QM8Y/m8KMNpg1HOat
         C4CriwbK6MutqdFwLlu5m6hpGvWGz6LUnwAX287lqAfwbWxgV25rCFsjHlbqcyCCY6dm
         CIoT22WxV4qpG9Fz9ZMTOWbFCDiDDi+vMBhCm8JifRkLPbxgHZ3ArfAp1UUj4bGffpJs
         vXBBzlzHUrmy6xGmh9tWuub8veMS1OBNMfMCJa4EyaFJsl4yUMQorf3dr82HjDbVRZWq
         COrLQHD3yPSmz6NGChFC3j9lOkdUh55/R/oeomMUz05cYlvvxRfkgRKCoLZwmN3oJCFQ
         Cprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=2bs1IEC5bkjhSvfaVW9dgpFGXcj9hhVP9o5vJu5COR8=;
        b=MCGj858BDISAUD03rHGxNWAXFuMX41HWNFMCXQrLQRLiQzp0v63GK5zM6G+tFy5gjp
         QEGKB3bQtOPUXWpkg0iMKrQLIzzM5kmBESULvR06pvT2++bTivdJ8/Ep1jEDa1ne4Op2
         E7z6usrlx/fQPNjRzuMJ6MSWY/YlqpWKs6wWFjOTh1OTA974/KWPlBq0vYj1uZY0ER+j
         3AHI5r1cZiO291Xp5xvDx6GwzZgBk2+o17J45WDvRMEvEvDmjwJ6h77LB3m9eGooFrKN
         L7jE/gBDD5eeNWIS86laHz3tyleGPj58UZeFBs2KM77viVEHYwnR0MjS0yLOpS1ep7DF
         9DEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tFGMakFB;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tFGMakFB;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Thu, 8 Feb 2018 18:21:16 -0800
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us
Subject: Re: [patch v1 4/4] platform/x86: mlx-platform: Add support for new
 Mellanox systems
Message-ID: <20180209022116.GA25898@fury>
References: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
 <1517561148-38587-5-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517561148-38587-5-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591270896093123492?=
X-GMAIL-MSGID: =?utf-8?q?1591888190528574288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 08:45:48AM +0000, Vadim Pasternak wrote:
> Add support for the next new Mellanox system types: msn274x, msn201x,
> qmb7, sn34, sn37. The current members of these types are:

Please break this up into one patch per system type, or a similar logical
breakdown.

-- 
Darren Hart
VMware Open Source Technology Center
