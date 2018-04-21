Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbeDUUqM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 16:46:12 -0400
Received: from bert.emutex.com ([91.103.1.109]:53910 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753222AbeDUUqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 16:46:10 -0400
Date: Sat, 21 Apr 2018 21:46:05 +0100
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20180421204507.i77d6ov2je7e4ec7@localhost>
References: <20180419132036.27493-1-javier@emutex.com>
 <20180419132036.27493-3-javier@emutex.com>
 <20180421170505.60d7784a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180421170505.60d7784a@archlinux>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Jonathan, On Sat, Apr 21, 2018 at 05:05:05PM +0100, Jonathan
    Cameron wrote: > This is in principle fine, but I'd like to see it done somewhat
    more > explicitly. > > 1) Add the adc124s101 and similar families to the
   driver first. I think > this is just a case of IDs for all of > adc124s051
    and adc124s101. > > 2) Add the ACPI ID as you have done here. > > That way
    we at least reflect clearly that the part is supported rather than > just
    in a comment on the ACPI ID. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 21, 2018 at 05:05:05PM +0100, Jonathan Cameron wrote:
> This is in principle fine, but I'd like to see it done somewhat more
> explicitly.
> 
> 1) Add the adc124s101 and similar families to the driver first. I think
>    this is just a case of IDs for all of
>    adc124s051 and adc124s101.
> 
> 2) Add the ACPI ID as you have done here.
> 
> That way we at least reflect clearly that the part is supported rather than
> just in a comment on the ACPI ID.

Will do for v2.

Thank you!
