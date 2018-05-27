Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936324AbeE0JOz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 05:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934567AbeE0JOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 05:14:53 -0400
Date: Sun, 27 May 2018 02:14:52 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Message-ID: <20180527091452.azwuh5u7rjyy7z6h@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
 <20180518223032.ihszdef5wesj5nie@cantor>
 <20180523125655.GB363@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180523125655.GB363@linux.intel.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 23 18, Jarkko Sakkinen wrote:
>On Fri, May 18, 2018 at 03:30:32PM -0700, Jerry Snitselaar wrote:
>> On Mon Mar 26 18, Jarkko Sakkinen wrote:
>> > In order to make struct tpm_buf the first class object for constructing TPM
>> > commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
>> > entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
>> > prints an error message.
>> >
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Thanky you Jerry. I'll do one more round for this only to update kdoc.
>It does not involve code changes so are you OK if you I keep your
>reviewed-by despite this update?
>
>/Jarkko

Sure
