Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AH8x226nBWHKoxAOjeEaG44qIxx5bXH7Y4ffqutgiJLudcMbfo0j8uRMDc2BGJN/vWFXHF2dgbrl
ARC-Seal: i=1; a=rsa-sha256; t=1519233234; cv=none;
        d=google.com; s=arc-20160816;
        b=GqVmKM6bfB0FBhftKGdRG+3haj73NMRHFk4Ae9IJJrAc158GXyg2vMRK/zebwwtKOA
         UrSRLJC6davceGPOUtqWu8m03bjIV8bNGkeHexiSdcbQuMkLsiJPCajAhbJZBjyx9q0x
         aeLa+eMdh2s1E6raJb6EM00Sm1bfDWqovl3zjjhqMPmhHrdNgqUgWt3HI+klGrW/JQoo
         RF95O0aMos3hfL/9aClZKVcGojbRp/dJB49NpI9jdXxr0LWaJSPl5vq1l1Sro4lBnIOS
         4HnOaZBlnlDTp3uDSJIavUVVA7YN5NADQdUwLEe5O4zZlmTLBeU5aczgyUXmSnYpYq7K
         Xs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=jGV+HbD9c+1aeQqWzH+kd2zpPrpFgE2S1finw5VaOaE=;
        b=IE7PNII1CpidC/lYfKQTPnyddTX+6iAeufI0oyJaci1y5PabR8nizAob3pJFEtFJb2
         +NK3JzYlUt+Ph65L6C/qhk6Sj69BgqGHPRav10pF1i0A+Oh7xa62U1K9R6XR0vEimGMT
         ZWVbxGmPMc5NvAoRl8lv9huJHjKx1igHpvq43vaoVRL/NSpXYBnAjCA9sl/mIJ6mOjad
         CWCyLxTQ8keOPvlLO/jBCSn0ZaqW8LshocnPMCi890cyBzaToxFMyCgEHZsVIYfBxaw2
         2G63sIWS+lRBETAmFnbC+7uYyv+2xBsHnDBl3mWiUE/pR7cxOIRIQ9uYay5uyaY1V9Yz
         ldiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@lunn.ch header.s=20171124 header.b=WCZqK+Ll;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@lunn.ch header.s=20171124 header.b=WCZqK+Ll;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Wed, 21 Feb 2018 18:13:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
Message-ID: <20180221171349.GG29204@lunn.ch>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1593031507646630381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 08:16:00AM -0800, Jae Hyun Yoo wrote:
> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
> AST24xx/25xx SoCs.

Hi Jae

It would be good to separate this into two. One binding document for a
generic adaptor, with a generic PECI bus, and generic client
devices. List all the properties you expect at the generic level.

Then have an aspeed specific binding for those properties which are
specific to the Aspeed adaptor.

	 Andrew
 
