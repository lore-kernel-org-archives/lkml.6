Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeCIDOf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 22:14:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28346 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750898AbeCIDOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 22:14:31 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37653326"
Subject: Re: [PATCH 5/5] kbuild: move modname and modname-multi close to
 modname_flags
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kbuild@vger.kernel.org>
CC: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Govind Singh <govinds@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>, <linux-kernel@vger.kernel.org>
References: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
 <1520471103-10089-6-git-send-email-yamada.masahiro@socionext.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <f4660c10-5481-3308-1117-6a71666c1674@cn.fujitsu.com>
Date: Fri, 9 Mar 2018 11:13:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1520471103-10089-6-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 452E548AE762.A5B86
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2018 09:05 AM, Masahiro Yamada wrote:
> Just a cosmetic change to put related code close together.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>

-- 
Sincerely,
Cao jin
