Return-Path: <outreachy-kernel+bncBDJI5MPT4AIBBC4R7DKQKGQEV3VQNNY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1522403467; cv=pass;
        d=google.com; s=arc-20160816;
        b=NkK0+3gBtJwAFC/EuS5adSKW0cWWWwEB2K5yb520qOhpWJVduQfAHw3VmhHohpyECW
         4R225W3pJ9vJiht4MYjj10/AFqNuQnPw8LzQ5hw4Iw6tYCG9aaLRL2w+XG2w6+R53HqE
         oiE3dxiCwyzKEvhtCeAJmhgIWYfHhpItqo3bqlnanYMJLo2dOP1I/vylXgDlRwYrCaSZ
         8gPRxX1L2Eo6C3lgYsGxzeG3BAEYIy9qIrX7D0tsBRZFO7s1buaXTj5mDQNM0p3ulWCD
         wGL+vAaSqnIUsecuRhVXdlZ13cb605Bd9ChcHhR92Rpk7GdXqe2aZ8c0MyOcGb2yFc69
         XTUA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=xpOU23rxu7Wx+OnUdNMD8V0ZkMnutSgBpOM7dML2Y4k=;
        b=ZWdxXXEkGpRQaToZbKHkqFGBnrGwYu2zY1NdoGXruiY+lEz+ZXP1pEpRhLt5pOkAff
         LrmF8i9dr/pWtcu6ZrfsEcW+vJ09E8MG0m9jDBevbpUYEORa2qefbaBOFxzlK7EO8/VR
         chzYEfDQfbIr6+LzwQgdSjlOb/Tizctq/1kTtlKRv4DTBV0QYMAEb60bV9J5TP1F+h9W
         oNDAGuAKhMgohUexgbCvXZBrq2Z7lLvKurdlw2RZd+WVkSU5SxOnCKFojJt0Jzjt8Vjk
         548Lh9kPJV/doiHlSyxSGmf0WLhg9uZQD6D/XeJBnydDfFFW4T0lIZZu8ivwVpq9GVFh
         a8zA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=bLicxzI4;
       arc=pass (i=2 spf=pass spfdomain=us.es);
       spf=pass (google.com: domain of outreachy-kernel+bncbdji5mpt4aibbc4r7dkqkgqev3vqnny@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDJI5MPT4AIBBC4R7DKQKGQEV3VQNNY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=bLicxzI4;
       arc=pass (i=2 spf=pass spfdomain=us.es);
       spf=pass (google.com: domain of outreachy-kernel+bncbdji5mpt4aibbc4r7dkqkgqev3vqnny@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDJI5MPT4AIBBC4R7DKQKGQEV3VQNNY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1522403467; cv=pass;
        d=google.com; s=arc-20160816;
        b=mxe5KYXYPD/TNgWwK/DXmgTk+/liQpRU22uiZIex1Xlq5L3II66ksGZLd5tdkmxd5f
         k0YlBA6eqRGJ3BGfSieTONOeE1eWCGF7vET3QldcM0V3vzbLgy40msVOIpgZMjMFKacO
         OYzzhfsnr9lMmTOl083YuTMHAUdpcqGJ+ZWuzlbwcxtwgTpYQGzJ7rPnkWoITvl1Ci0Q
         r41EzD5oFoLK0Ud/A3oLqKd1rqpy/x4fMqPDDUN+EzLw74dxW2ZkSQx5p17/cD+6sQSw
         kQwGukrbWh61xvF3FLMp3dIczpRUOom86kTVH0wnyhKSeXmuQLZAAUqMpApI/Ly6xaxn
         Z1QQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=xpOU23rxu7Wx+OnUdNMD8V0ZkMnutSgBpOM7dML2Y4k=;
        b=boHnZQOxHS5m14lkhDubMtQVIFYupyHkP1cp8LJILeDVhrMkxkjXyJahG1S/qizUEB
         /fo6C0nfq/Ps8DNbkKRMKi9M4DIYtgMo9an9PlIgDZSqujz5wm6TWSq8O738ugGs3/xP
         IR77ZZ5191UcG3r/impsVzvjXrtambb1QR4wHfHwDp80+dcYB0tqGpYhHg1l5afD6coN
         j5Lt7AEN0DGS5S4KrREzNde8Ix4Xb1i3rMn/Raa54xW9xfJPlPfpUwu9K2EavvurD9D6
         qVVG8TvqoWysbL+igPJkFRe342exUlCRb9ju87FDy+juZqfGcm3SoJuOJIFVUWdMuO4h
         EaRQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of pneira@us.es designates 193.147.175.20 as permitted sender) smtp.mailfrom=pneira@us.es
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AIpwx4/3342oGFUxBQpVzHX1J9nMBx8civq9MTF4q+C5HZnyfy7rOs+0Cbk1UwEHgjOYqfZIl+uSUQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1522403466; cv=none;
        d=google.com; s=arc-20160816;
        b=n4v1vZpSgJ3nXbUSVo2yoqfjTJlWSpwOPtKDeyyy7kdY8XBK8zuYc9k/a41rNhCN1m
         UVYB2roAZDk5wxrfLnxUEl8DfDX0Q1qzd6eAF0Fe0oagHtZvo5/0MOy6Uri99unCjJMx
         4FAnLJqsU1g+02rI5f0ylPpTeM2aJzu6bWPU2MSLeDEW/kGg0CBqwGgGxqldJSv4udAU
         eFpG5t2Foc+WOpWg5oGO/IvRtCDLYnmeP6CbkUpAbeRwRAALBMwtqO9v9E7GqeiNgOGN
         sXVa0OEVekJNb9ApipKAgWB3cBRQ7jvZjRXdqgayeC6GpRFN3DnpF4zT6ei7pJfAr7lz
         O+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=EGzSBnni46b0zYzP5gvCj9ApBr0e9dK8d6u+Tv8pME0=;
        b=IV1dOi2aKFHyQ3EZOobjLQUmzGCU1A6v0wyrtTHruQTP8qytQfHxCeeMXsBLj5VF2s
         HTgN7gyDWoPYx9OupEeSPAbi944TJ3FvLIzprHu2pOvQHaH7kBU3vjs7dPIYSr2dzQsr
         jycdujSMNZyGybAeILi/PGSXiG6k0JUywCfzvHEIPax7wshKe/tsOs1eVJ6go06gahVK
         0STjStEydANulaBydxI/eH34RxNrezrrmszSu8uAOM//zu6rtWOENlceZK+Lhib8oZSc
         z6znwSEtxmdNqDTaB+OuADLVUH5IsXCmRemj+oRtLRJHzRkcVDpvND2k+Dp+Tm/qRk2R
         qyjw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of pneira@us.es designates 193.147.175.20 as permitted sender) smtp.mailfrom=pneira@us.es
Date: Fri, 30 Mar 2018 11:51:00 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Outreachy kernel] Re: [PATCH] net: netfilter: Merge assignment with return
Message-ID: <20180330095100.gujsk7v2rot22eni@salvia>
References: <20180328190950.GA3151@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180328190950.GA3151@seema-Inspiron-15-3567>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Original-Sender: pablo@netfilter.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pneira@us.es designates 193.147.175.20 as permitted
 sender) smtp.mailfrom=pneira@us.es
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596209702586221835?=
X-GMAIL-MSGID: =?utf-8?q?1596355738618591283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 12:39:50AM +0530, Arushi Singhal wrote:
> Merge assignment with return statement to directly return the value.

Applied, thanks Arushi.

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180330095100.gujsk7v2rot22eni%40salvia.
For more options, visit https://groups.google.com/d/optout.
