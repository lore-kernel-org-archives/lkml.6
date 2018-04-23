Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbeDWLBr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:01:47 -0400
Received: from s02.spamexperts.axc.nl ([185.182.56.112]:47499 "EHLO
        s02.spamexperts.axc.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754787AbeDWLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:01:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Apr 2018 13:01:03 +0200
From: Pascal Roeleven <dev@pascalroeleven.nl>
To: maxime.ripard@bootlin.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Fix incorrect clocks
 for displays
In-Reply-To: <20180423071421.byupsz4gxpmhfe44@flea>
References: <20180420102112.2843-1-dev@pascalroeleven.nl>
 <20180423071421.byupsz4gxpmhfe44@flea>
Message-ID: <887c9144972ab75a4520141a17e1607b@pascalroeleven.nl>
User-Agent: Roundcube Webmail/1.3.5
PrimaryMX: Accepted email from trusted host.  Hint: This skips spam scanning so make sure other host is not vulnerable
X-Relay-Host: 185.182.56.42
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "vserver22.axc.nl",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On 2018-04-23 09:14, Maxime Ripard wrote: > On Fri, Apr 20,
    2018 at 12:21:12PM +0200, Pascal Roeleven wrote: >> Some displays on SUN4i
    devices wouldn't properly stay on unless >> 'clk_ignore_unused' is used.
   >> >> Change the duplicate clocks to the probably intended ones. >> >> Signed-off-by:
    Pascal Roeleven <dev@pascalroeleven.nl> > > What was the difference with
   the first patch you sent? > > Anyway, I've applied it, thanks > > Maxime >
    > -- > Maxime Ripard, Bootlin (formerly Free Electrons) > Embedded Linux
   and Kernel engineering > https://bootlin.com [...]
 Content analysis details:   (0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pascalroeleven.nl]
SpamTally: Final spam score: 0
X-Originating-IP: 185.182.56.82
X-SpamExperts-Domain: vserver22.axc.nl
X-SpamExperts-Username: 185.182.56.82
Authentication-Results: spamexperts.axc.nl; auth=pass smtp.auth=185.182.56.82@vserver22.axc.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00707305160397)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sZWPgoG9A6BM/DrXs3mBL1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO01c7t7BiHkROxieRAgMjhj9NTFFPuvqPiGTFfLuvLv+7Zl3j5VIQEtsGGxM4ibFs2bp
 vuk2H397d4iSK3nh/8fyHC7Trb0yHaCuBe+zVs1zDzCjdvuLlNprJt7sM9U2tvEm1xUk+uitP3zt
 fVUM86qADZEAq6MVvDzVG1eBiMwsxonw6auRGB+OqkfrxZvcAu63p/UbUTcmIpuXtxg/CxlyFZQN
 yGR1xdWr/EMlluN/HaaU/Zb275qB1xqcfpxQM78iXoKuit7KYsvfORRN32/uqqHf0YlM0FoFl5SM
 CrNVm5UrAVUJXWCOkjmLx5rfPWJqWWpqOdpQykhUmzfN+rpd3FLLN5JZzRmnU7SUHT2Pg8CBO1Sn
 vm6qXHQp7O9kdXzJqywiCyRpWLvaQP8TpD1s24tFNcrW2H3oHk7M+t/IGFvlHOQsi9fJrQH2HB7K
 cn7E9n664KB+xMpIjboCH5KLZs4XEHfQdJxMWQNlIJHit1AzVHmN/1Ca6vYbegKN9pDtMXpd47Jk
 uyvi9F/b5Xr+q263SxhPVtF/V2M9L7dcNvokIFGx07bhuY7QrNII/xIn+RMmMo9n/zJo//hfCVlk
 AdhK23InA2zzja5I1riDJBcOl1Sca1tCLiymrRRXBKDkaM024bykcyHR7I4FbmnLRaO3oh2Y+QPh
 zq1ed4hKPsarl5dnGXsBogEFWhbvijo/WtzAwxKxmN+PCLjJS1n9BQ7dDQWLiI0sLYm4yP/7OMye
 V7249X2e1GQHGQCkca9WJmbhekdrgcJsDlHBdahrSlHVtLHaZkFpoXAuc0NSEIfqJfx0xnvORO1u
 Vic89WCijbR5gOtRiEFrJGnSGxi96t0jSpXk/FZ1fwcf7/prCnx4FGUWiONpnHe100SbOuHRfOND
 F4cVqm7lmX5VA+Pwnfs6UYm2Ai3DKHJBJpSzwr8AJI+ULtNHd99UioyGXUy4L73dGT+pP/Hi7yJ7
 6rVy2DNwOgV373pfDhBQ21OdRS1J8Q9o9wsNBuY1VdC8WZCMICylBBeA9ExrvE2k+wP4j3vl9ilE
 NAJdELfMPSIKfhWFL18GAOeh/x4RI75Pxakgsnq2YdHMNQhGOMdLA4kBXtD10+3+aA6m3yQ23IEc
 XNM8K+LjoSSEl2/JdfLG6TwbaO2SDHRS+6qA2mIAaxiySMNG8mWJheziSx58QXxt
X-Report-Abuse-To: spam@s01.spamexperts.axc.nl
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-23 09:14, Maxime Ripard wrote:
> On Fri, Apr 20, 2018 at 12:21:12PM +0200, Pascal Roeleven wrote:
>> Some displays on SUN4i devices wouldn't properly stay on unless
>> 'clk_ignore_unused' is used.
>> 
>> Change the duplicate clocks to the probably intended ones.
>> 
>> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> 
> What was the difference with the first patch you sent?
> 
> Anyway, I've applied it, thanks
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

I'm sorry there isn't any.
It's the first patch I have ever send so had some git-send-email issues 
and
didn't know the correct procedure to resend a patch.
