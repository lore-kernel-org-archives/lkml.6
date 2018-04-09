Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeDIRYG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:24:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13212 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeDIRYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:24:04 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 09 Apr 2018 10:23:54 -0700
Subject: Re: [PATCH] Documentation/vm/hmm.txt: typos and syntaxes fixes
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20180409151859.4713-1-jglisse@redhat.com>
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <680b24d9-1c6b-a16c-45f3-6fd7a31c3840@nvidia.com>
Date: Mon, 9 Apr 2018 10:24:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180409151859.4713-1-jglisse@redhat.com>
X-Originating-IP: [10.110.48.66]
X-ClientProxiedBy: HQMAIL102.nvidia.com (172.18.146.10) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/09/2018 08:18 AM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> This fix typos and syntaxes, thanks to Randy Dunlap for pointing them
> out (they were all my faults).
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---

You can add:

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
