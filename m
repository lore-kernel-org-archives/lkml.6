Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeFEIQ1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeFEIQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:16:18 -0400
Date: Tue, 5 Jun 2018 10:15:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/47] 4.16.14-stable review
Message-ID: <20180605081556.GB9155@kroah.com>
References: <20180604065549.468488465@linuxfoundation.org>
 <b28c44a5-92c9-f9e5-a056-0a6ebf5326a1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28c44a5-92c9-f9e5-a056-0a6ebf5326a1@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 06:20:44AM -0700, Guenter Roeck wrote:
> On 06/03/2018 11:58 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.14 release.
> > There are 47 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jun  6 06:55:34 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 136 pass: 136 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

greg k-h
