Return-Path: <sergei.shtylyov@cogentembedded.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521103115; cv=none;
        d=google.com; s=arc-20160816;
        b=P+ehdMJ6IbJUfS/JITSqzkSpk2wn8rpx2WLiZ8SOh1M6BAKudSNeRGXgHgtuoq5ugQ
         OqkHb/5uB1O5xiNXWFQ4ddcqmfx9XQ7F5o9EHOgRgAqGhdvrI2p3yoUQ3ZhfC58mVlpP
         83kE758Pmsy8yl0DKDw84ippcF34XlHjd8aqkpvrCS2IBRKeSn4rHFEv8oRE4DIo0WUB
         5ux+zBLb3iD08nVRjvJXltjjM5jlVsega+rXpUg8TMnXDUsOTSRrlbOoKVeXtTeKtaGP
         ZtwlhdP3X1oZ4HnQLoAxXiWuiv+aZkpH3wSd+udXeWTTLEh3hk8Ldxx+QDSZuWwIHp0q
         RsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Pa2o9kfkBIbV4VUKMUKNeYvYzqzYZ52WOKb3tCkBTds=;
        b=vO/ufESOTn9BkgVVYWzey8wZZP0bLtDaAdNAihBZ/rRnOxbzOJPlbxcwWJ9PyuPRZc
         hRgj1B2emsSZMVw8I6msimel2VBwl7XPr4nQXuML7vYn35lMxgDE3unywmKSYySJGpMP
         mnm/P5CEFc4i0ygM2Bi6hmGj/fqiKB7o1N+OkyLpEF0xhUuOKwdPS/QvsSPAF80Pz2hR
         6J6Gi8Ofwkzjw+lqRNRAWRRv41avRo/PsAvOfeLEqVlBWqufs4ccBS97wMZvEbsbPtvO
         WgSZHbjxJkJEJ/sLH/nyx2/OjlRyqT8sersGY3H812STDjAQ4zaPx/e11dWEq6oNlqbc
         xG0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=UVinkphC;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=UVinkphC;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
X-Google-Smtp-Source: AG47ELuUdok5xUuAhIQ8YjnLRIX61126oAsbDxXYYWA/RvOamLWAXPsjqQLAXgky5uz6h1P7tdj96Q==
Subject: Re: [PATCH 1/2] sysfs: symlink: export sysfs_create_link_nowarn()
To: Grygorii Strashko <grygorii.strashko@ti.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180314222624.12744-2-grygorii.strashko@ti.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <45cb657e-78c9-6a22-337c-c68306215e00@cogentembedded.com>
Date: Thu, 15 Mar 2018 11:38:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314222624.12744-2-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953712390716409?=
X-GMAIL-MSGID: =?utf-8?q?1594992221218193344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 3/15/2018 1:26 AM, Grygorii Strashko wrote:

> The sysfs_create_link_nowarn() is going to be used in phylib framework in
> suseuent patch which can be built as module. Hence, export

    Subsequent.

> sysfs_create_link_nowarn() to avoid build errors.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
[...]

MBR, Sergei
