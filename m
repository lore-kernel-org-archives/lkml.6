Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeCWWTU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:19:20 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43750 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeCWWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:19:19 -0400
X-Google-Smtp-Source: AG47ELuOGRiNfg0dP+kyN71/eZs3egzY67a1FCBT6Xs9ea26zEvJnYcH7B5C7jIPXkV3MmvoN4c9Tg==
Subject: Re: [PATCH] dell_rbu: make firmware payload memory uncachable
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
References: <40006403-999f-fde5-316a-63e9a48ce11c@gmail.com>
 <201803231026.VpXzK8BL%fengguang.wu@intel.com>
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <aea5df34-6f26-df13-c6c6-5d287d42db4f@gmail.com>
Date: Fri, 23 Mar 2018 17:19:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <201803231026.VpXzK8BL%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2018 9:58 PM, kbuild test robot wrote:
> Hi Stuart,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc6 next-20180322]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Stuart-Hayes/dell_rbu-make-firmware-payload-memory-uncachable/20180323-094405
> config: i386-randconfig-x014-201811 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 

Please disregard this one, will send a "v2" shortly.  Not sure how I managed to send this version...
Thanks!
