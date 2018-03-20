Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeCTTtM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:49:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52422 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:49:07 -0400
X-Google-Smtp-Source: AG47ELtKoGMePrpr7vtmtVWJhfypa7/sEbVYDiltIj1kXzGNd0u0l/Uln2YdW4/5rj73yPKhHDFXBA==
Subject: Re: [PATCH] modify one dead link
To: Sergei Trofimovich <slyfox@gentoo.org>
Cc: corbet@lwn.net, yamada.masahiro@socionext.com, tony.luck@intel.com,
        bjorn.forsman@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180320145422.24331-1-mudongliangabcd@gmail.com>
 <20180320194203.205c6c60@sf>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Message-ID: <285f442d-c4ad-93be-c3c0-ad04c37f21f8@gmail.com>
Date: Tue, 20 Mar 2018 15:49:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320194203.205c6c60@sf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2018 03:42 PM, Sergei Trofimovich wrote:
> On Tue, 20 Mar 2018 10:54:22 -0400
> Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
>> -    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
>> +    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable
>>       # cd xen-unstable.hg
>>       # hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
> You will need to fix a 'cd' as well:
>      cd xen-unstable
I will modify that problem. Then resubmit the patch.

Thanks.
>   
> Otherwise looks good.
>
