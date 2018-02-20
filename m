Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeBTUcZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:32:25 -0500
Received: from www62.your-server.de ([213.133.104.62]:58774 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:32:23 -0500
Subject: Re: [PATCH] tools/libbpf: Avoid possibly using uninitialized variable
To: Jeremy Cline <jeremy@jcline.org>, Alexei Starovoitov <ast@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <01000161b0b991f8-7579000f-4510-4073-b081-a0ddd60d2090-000000@email.amazonses.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e654d851-7dd1-d395-c83a-b5d0cc8b211f@iogearbox.net>
Date: Tue, 20 Feb 2018 21:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <01000161b0b991f8-7579000f-4510-4073-b081-a0ddd60d2090-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 02:00 AM, Jeremy Cline wrote:
> Fixes a GCC maybe-uninitialized warning introduced by 48cca7e44f9f.
> "text" is only initialized inside the if statement so only print debug
> info there.
> 
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

Looks good, applied to bpf tree, thanks Jeremy!
