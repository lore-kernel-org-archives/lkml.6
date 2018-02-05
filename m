Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbeBESgD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:36:03 -0500
Received: from mout.web.de ([212.227.15.4]:52118 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753972AbeBES11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:27:27 -0500
Subject: Re: hid-sensor-accel-3d: Delete an error message for a failed memory
 allocation in hid_accel_3d_probe()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
 <20180204112346.0977e938@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
Date: Mon, 5 Feb 2018 19:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180204112346.0977e938@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:IxGo7kVmocRO2j0OuKStjc8tPG7Z5wz/ZNuIQCFR+YvPIfJB9PM
 MmHUxIaYWsz8jbldP4gnUUb50S0g0iNErphw66PLQbVYB/aYoXBQGpcVJWZ32P1/hgJp/bo
 +fXdC1PAY3SdXZwYMO7xLdg/ycPqCA7d3XtxcwbJ9zaB/TlVdt0HfZ7MO6Z7tW3wR8NJgty
 S9nT2kc5oiUaGRG1BkHLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pnK26igklLM=:Sc6Cazfg7KIGE1S0bybVT4
 5jQBU80R7RakmFTbxfuVikLFYS/wJeI6m9B2Om1GhASxuEfjfiWm0vgnHQtnUxUMgzyqhMMXv
 ZgTjr8JFGrrQBa/nCEqKo9uINAYSlhIJe/sdPdslwRLKTEskJ2CuAA3ANZdI+ebym8WJCoS/u
 zhsyW9Uj721njH0+ugvnyfCTtK30xt82dBq3TIIzMqsnelJBbAvGdnCekf2W7+t+IHSyQd6ty
 1Z2Z+4jVhgCbSw0cvDr2pOhlyjy87R76ex2aTlueuTU9vRciEgEHUlnPXeRXlm/0LCdNWUQOE
 ofDs2CYuVsfBUUdHAlLpqgbqhtc8F14QTzrbTctBBCJTiM5rmBrKh1dbK8IZlsm7R/siVnqD7
 5aNe0AmWmOogPpgkx2WUMFIsJNPr1p4C1KrqIwSBcyBCYo+LtCP9TaJOGf4m2C7V+7+d6U5Y0
 ff2k0W7jaS4wJhDLwOGKTKLjRb3CvV3lvlFn6xVk4Hc58QPPgw2Ntr7JtudkSfTpm4kYTNnXr
 onkMX+cYA8+EpMTwSCRnRXZZCtMwfHCJY9t/VTTGu+aiX0nK0xf+99Q5MyGHKoe1SRYthEkUr
 +4KsT0osh2OLXigU1dczk+t7bwt5Hc8G/133dQUeU7EH7h547eqs0q7bAZX+mvw4PUCapUHoF
 5hWIgJ4keMKTiUUa92/jwx2BXCL3I6JWWhjkirr6sGe/3I/S99iaUNcKLA6e5/dF1hc9IO4lB
 tdSOkwTIRZ70slevODblbIL1oFpg7/I73FpXSWHXfw4kjwX2IvHakMbXGadQOqljwdpPytwWo
 mTB8SPLfEBdguwOfCus7kqfTwytXDbRgrXEyc3SxLflUHm6LGA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If making changes like this I would suggest only sending one until
> you have have a response from the relevant maintainer.

The corresponding feedback can become more positive for such
a transformation pattern after a while, can't it?


> It would save you time as often these sorts of changes are
> a matter of personal taste and weighing up of costs vs gains
> - hence it is not obvious that they will be accepted.

Can the wording “WARNING: Possible unnecessary 'out of memory' message”
(from the script “checkpatch.pl”) be another incentive?

Regards,
Markus
