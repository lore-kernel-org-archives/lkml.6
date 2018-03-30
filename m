Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AIpwx4/o3toA40UMgAh36JVroY7DzDopLXEjSgeZJ7lfryamTKwJ+OGRaJ0rHRyQKaMufoj+0VGR
ARC-Seal: i=1; a=rsa-sha256; t=1522418746; cv=none;
        d=google.com; s=arc-20160816;
        b=Qd1vs83OPTeYsYTqVcvpuvCn02ihkRJLrqRhes8ExQywx/Ok4LifNJUpaOIYVdTrdA
         er1cvj6ICNl/iHIeuLcUnESkyqwgg9UGNel3Qzc/hdpAtZMdjqQy/CySgq8Dbe3m/xOR
         jQWmPV3OFrK2maFtvjW4xBb77TXBp3VzoorRgY4fz2Lxxec1M0JEIGedBdeyUYb1SMzn
         USMhAeV8Usc3QtfecLAk+H901+akhW+lYoJshrrZdyc6cvVKCqpRLX0TbCfI3a5vd4Eg
         FmcYOvsOnpikbew1GcMAWwiz1V4IvvcQgCfqH9/QUwj93MNzja+nf1rE7+RQH2QW+nJP
         ZuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=O2cIR/NDXhihL10td7kFvB4p86+oyvG65nAnX4xdIYU=;
        b=hc7rPEJg1mIXWBFacOcebPQNr0z79P6TcQxYWS06Ee2JBHEEVIDFjXRi4GGj7Z1ECF
         jUwSLqCeSuEqCKUyKzUokCEKIQdLtAe805b6Uix1wwcRWrHuEO0cCkxzJx062CYzu/4h
         9J+a/OWTDh9ULxwzIqUbZTuU+Q0nAl9gRqi8ZvgGMtqytPlc2QC3VNseBcUfdMrqjodo
         RqBynb+uIbS6p5oFR+UzWLqB2GvnGC9ZR61E4RDqxYzXSn+IizEM5P7bTu/eZdNC8yiE
         czFXiklplxFcTtNUVFMzEe9h0M/iy3TSse15SoAqoVB0vpPVX7Q0gY6usCVGPiBkCEoX
         5Y+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Fri, 30 Mar 2018 10:05:44 -0400 (EDT)
Message-Id: <20180330.100544.1314252133038093727.davem@davemloft.net>
To: doshir@vmware.com
Cc: netdev@vger.kernel.org, skhare@vmware.com, mchehab@kernel.org,
 gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 akpm@linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: update vmxnet3 driver maintainer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180328223834.5452-1-doshir@vmware.com>
References: <20180328223834.5452-1-doshir@vmware.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596222849906671702?=
X-GMAIL-MSGID: =?utf-8?q?1596371759425430480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ronak Doshi <doshir@vmware.com>
Date: Wed, 28 Mar 2018 15:38:19 -0700

> Shrikrishna Khare would no longer maintain the vmxnet3 driver. Taking
> over the role of vmxnet3 maintainer.
> 
> Signed-off-by: Ronak Doshi <doshir@vmware.com>
> Signed-off-by: Shrikrishna Khare <skhare@vmware.com>

Applied, thank you.
