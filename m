Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AG47ELvalnmvAvyhlDHPsycgD1fqkZ2NKlxUbFBFZDOeDPDD/jVZINxwY7wGYZCoP1Wo5qkiMapi
ARC-Seal: i=1; a=rsa-sha256; t=1521234905; cv=none;
        d=google.com; s=arc-20160816;
        b=ZCkVVyx/ZMV0DRML2Wvu3YdOsr9Tncdaqy90NpBXXj5GjyLIy0dbNwThB8iQYp2V5Z
         xxvAqVxWfhtSVVs/772M/aWBWaATtOmGCpwteNyNgRiGgtEEACvpNBHQQ/M7G0B3eAiC
         2HnHfgioZY4kL1ENIDFDtTKz6jyc6HPTSuUZax/LM7bSApXhfH5oLxbZNs0jEwdEaw/v
         Gh2cq/M2M+7OSSAeHipxuI8AS26bD60fBLpvb9ZkhxHPsbZkc/rJJrN1bd3Igs3lrI+k
         psikZ4nlWi5yPRP4ezfDhbsVZpZcI9EOZ3xuKEGaCdoiH3PHixbEp3oaqlTndxyCh30f
         rYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=fBF+UViAH5ccyIxdlcLz7Ky5DC7uENYRk583jxgaAr4=;
        b=VPG7TA0uhJgDbqnRlPp6Q1bRU9wku8JEOXAriC0s/JoA91TRzMUshzGYF445MuacX/
         3Xsw5iulSB65vnsR24Xd59BVp2U0HTdthlCIkRFw3r3dxqbC8ehr/uI7Mua9MGE9E1U/
         YZnIetx5b/9Aki9e4XfNOYRqKY5XwBH2iEkImqqtA+RToLmJkMzI8srZ8DO26HHMylfz
         hIx1THicmnPdrlSt/ZWoQeSgOROAuEAte17io0rlOIFOL1neo9sHvBDYe8mmGZQlfxgv
         WLwMq6gdc5uL26B0CdRaNLjlLVwH7JpWw53zEqI9/mSPc+lG7QLV+jJMy1oHQmnVlnNv
         HWHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=aFohYK3t;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=aFohYK3t;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Fri, 16 Mar 2018 22:14:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
Message-ID: <20180316211459.GC8735@lunn.ch>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
 <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
 <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
 <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com>
 <20180316195403.GA8735@lunn.ch>
 <0daaae50-ddb9-8a94-d4a7-02861f0a6eb7@ti.com>
 <c790757c-0b4f-575b-1f6a-5f870f840e20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c790757c-0b4f-575b-1f6a-5f870f840e20@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595130412601346764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> I agree, let's not have you run into circles, let's just use your
> patches as they are since they fix the problem and are not intrusive in
> any way.

Agreed, this is too complex, for little gain.

	Andrew
