Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753947AbeENHLU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:11:20 -0400
Received: from ozlabs.org ([203.11.71.1]:56335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753916AbeENHLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:11:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, jdelvare@suse.com, stewart@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] hwmon: (ibmpowernv): Add support to read 64 bit sensors
In-Reply-To: <20180509172926.GA20996@roeck-us.net>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <20180509172926.GA20996@roeck-us.net>
Date: Mon, 14 May 2018 17:11:14 +1000
Message-ID: <87y3gmpv8t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On Mon, May 07, 2018 at 03:55:37PM +0530, Shilpasri G Bhat wrote:
>> The firmware has supported for reading sensor values of size u32.
>> This patch adds support to use newer firmware functions which allows
>> to read the sensors of size u64.
>> 
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> I won't apply for the time being since it depends on patch 1/3 which is
> outside hwmon.

Do you mind if I take the series via the powerpc tree?

cheers
