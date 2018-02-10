Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeBJOxo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:53:44 -0500
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39856 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBJOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:53:42 -0500
Date: Sat, 10 Feb 2018 14:53:36 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jiri Kosina <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: Software evolution around =?UTF-8?B?4oCcY2hlY2twYXRjaC5wbA==?=
 =?UTF-8?B?4oCdPw==?=
Message-ID: <20180210145336.233c721d@archlinux>
In-Reply-To: <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
        <20180204112346.0977e938@archlinux>
        <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
        <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
        <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018 09:45:48 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> > Check patch is dumb and often gives false positives.  
> 
> Would you like to improve this software situation anyhow?

While it would be great to improve checkpatches false
positive rate, it's very nature as a string matcher makes
this hard.

Jonathan

> 
> Regards,
> Markus
