Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeEJW3i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:29:38 -0400
Received: from www62.your-server.de ([213.133.104.62]:50827 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeEJW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:29:34 -0400
Subject: Re: [PATCH] bpf, doc: clarification for the meaning of 'id'
To: Wang YanQing <udknight@gmail.com>, ast@kernel.org, corbet@lwn.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180510030921.GA25941@udknight>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c92bea6f-b182-1fcd-8c6d-5d5dc34567c4@iogearbox.net>
Date: Fri, 11 May 2018 00:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180510030921.GA25941@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 05:09 AM, Wang YanQing wrote:
> For me, as a reader whose mother language isn't English, the
> old words bring a little difficulty to catch the meaning, this
> patch rewords the subsection in a more clarificatory way.
> 
> This patch also add blank lines as separator at two places
> to improve readability.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Applied to bpf-next, thanks Wang!
