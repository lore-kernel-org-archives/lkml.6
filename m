Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeDXTde (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:33:34 -0400
Received: from bert.emutex.com ([91.103.1.109]:54589 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeDXTdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:33:31 -0400
Date: Tue, 24 Apr 2018 20:33:04 +0100
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc128s052: allow driver to be matched using
 ACPI
Message-ID: <20180424193304.yitnosi3vwirqlu7@localhost>
References: <20180419132036.27493-1-javier@emutex.com>
 <20180419132036.27493-2-javier@emutex.com>
 <20180421165441.0c64415d@archlinux>
 <20180421204157.y3zoejow7gfl3pj3@localhost>
 <20180424182330.000061a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424182330.000061a5@huawei.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Tue, Apr 24, 2018 at 06:23:30PM +0100, Jonathan Cameron
    wrote: > Unless we know of ACPI firmwares out there that are doing this,
   drop the > patch for now. I don't want to see a flood of these based on a
   'you can > do it that' way argument. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 06:23:30PM +0100, Jonathan Cameron wrote:
> Unless we know of ACPI firmwares out there that are doing this, drop the
> patch for now.  I don't want to see a flood of these based on a 'you can
> do it that' way argument.

Fair enough. I'll drop it for v3.
