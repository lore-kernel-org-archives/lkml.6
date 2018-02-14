Return-Path: <ukl@pengutronix.de>
X-Google-Smtp-Source: AH8x224KLjDfKP3OzBSyRbCNTLkXTeZqjmdE/bu9P6XD42NLNaEAbGxgltAsrT4Rw4lS9zq7SGjl
ARC-Seal: i=1; a=rsa-sha256; t=1518627623; cv=none;
        d=google.com; s=arc-20160816;
        b=nu01oXk3G4AzLnb1gb2VV/iGSjZ/8OSqYNch7qdgtnz3qilowarSNiuu4DkiAk0FDs
         KhAztwEyYJ57g+EiNf3KNHPohTwfEIByPWz5lmDEd44KLQrhAWbqySDrmhG47WYExixG
         pJPRVY010+6v/utnOvqPVNhZplV8aj6TGCfcFJ3RhUzgYIgc74a04WCDgqj4Dg+SIlKP
         II9qaKWTh/WBSA9J1/tB3khMxy9vEXmtL1hwgSK8E6Ldo5ZCd5/qjbvBr7Vf3eugX3Nm
         oxxwi+HbaFfvb/PRjiCD3PXya57okmcoWoMCXicq6DVyacACSseTN0Jd7qWboe0UswfV
         7GQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=AzryBQLAo/L8UWFlAAXwN1s2phmOzfTzVrx6HPn9Ej0=;
        b=fpuF1JvS/0A0Ed2VM9zju4I4c83x4cwfNIbP2G62vXu25Ebt8UP0RczjdHA5E4ueMb
         pujAw90LOmV/or6fnxnN3WCxA+jpZl1EKWMxmWqpFyIWaYhV09BfYETyI3wcaaZ1lTVR
         7hAyOQV/GYG2qLHaiXSmoXqNzcTxUcIfGH7oONkTMkg7TThqnNl2NnGo7dYh8Vgs3Hn0
         Kbcjn7wKpC0pgA8IymRkWYpUpgWtsfr4ofuMPNQ0mkj6hpza8VFmM7b4XjuHe0ftqD63
         +GVnp37s1fn/Gdz2ylhvFHFQJBD9Kr5VuC2jbD4rSZ8SQ3BA2PFpZ/AsMuHqqCUCLiGN
         iu5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Date: Wed, 14 Feb 2018 18:00:21 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Gavin Schenk <g.schenk@eckelmann.de>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	dcb314@hotmail.com, kernel@pengutronix.de
Subject: Re: [PATCH] siox: fix possible buffer overflow in device_add_store
Message-ID: <20180214170021.pf2di46t2ggfepim@pengutronix.de>
References: <20180214142502.20787-1-g.schenk@eckelmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214142502.20787-1-g.schenk@eckelmann.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592386720059475890?=
X-GMAIL-MSGID: =?utf-8?q?1592396478395332357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Wed, Feb 14, 2018 at 03:25:02PM +0100, Gavin Schenk wrote:
> Width 20 given in format string is larger than destination
> buffer 'type[20]', use %19s to prevent overflowing it.
> 
> Fixes: bbecb07fa0af ("siox: new driver framework for eckelmann SIOX")
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
