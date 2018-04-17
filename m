Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AIpwx4/Q6RXZ8+BgkWR4pGzw6SXp1aMA3/7oTQfemGdij8tmWI19uZfBBZNsf2IkREGrD1K8cOpk
ARC-Seal: i=1; a=rsa-sha256; t=1523946264; cv=none;
        d=google.com; s=arc-20160816;
        b=nB6UfRMHAnw1Q3kUdoj4tbH7fFh5pqH4vKDSakZkPzauezmqCj7kvN1NNDYbKnuFiF
         vNURb+a/uTFjARqVjPyzexOFMZHIMXdDPLO0HOCqotJevcQyG62sqdyCuLBgw2ejJN8f
         e1kNy3u/Z4VCF5jlMmYNRhRVRRw0EWacAV+MZeA0pPnz7wioH2oOrfmwUhWnM3E+GxU3
         jNm/6uJHu9vwAbjm7mq3+ify8gXEawM4p9N720wHJZFpC0sb99oN/I831KkXzH6Y9mxw
         PaIdQsYYtSCjYXPCw1gsXg5Jc4XVTqtbTlfv2qFw5CiUAfXtiHu98CFX/u+rmvadbgyq
         MHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=jCqBDxcd43nOjcanTRM6hVUhwXiMJzYQHRM4rXAMEXA=;
        b=X+8GO3o1hBs9HBaAtGn8r+Uu7ozRdIEahQS9Ech3zKe+PG/HUdktbgnlYO1+2uCdpY
         68EmJzTMFPcfYRDOIxPuYlNFENSe6NBmw74ofvv5rh70g7L/EoHYyk/tM9BBEueUk8Yq
         qO4RZi1OtgYq5viZuENcIW8iL/rBBEc5eMSpfpOegwmvfpKblN8Q0Hp2Azm5EKz+7jUP
         48aPR6oeEy0GWp/nnEFP3/r3gjP0VXq0PKoeZCan95na0s1N1p2/oj2ny04skHQAm7Zy
         qhoDTktqvh36SYySN9Q7hkRUa0lSlZKXb4P3OA29sTxsHrujGe9GcEMN9nJcxb7jeOmM
         iMGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [PATCH v7 2/7] xen/pvh: Move PVH entry code out of Xen specific
 tree
To: Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, pbonzini@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 boris.ostrovsky@oracle.com, davem@davemloft.net, gregkh@linuxfoundation.org,
 mchehab@kernel.org, linus.walleij@linaro.org, rdunlap@infradead.org,
 roger.pau@citrix.com, rkrcmar@redhat.com
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <1523920310-27620-1-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <4a68354e-6c97-9c10-e433-22a0f31cb879@suse.com>
Date: Tue, 17 Apr 2018 08:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523920310-27620-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597946300170778618?=
X-GMAIL-MSGID: =?utf-8?q?1597973477907387642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17/04/18 01:11, Maran Wilson wrote:
> Once hypervisors other than Xen start using the PVH entry point for
> starting VMs, we would like the option of being able to compile PVH entry
> capable kernels without enabling CONFIG_XEN and all the code that comes
> along with that. To allow that, we are moving the PVH code out of Xen and
> into files sitting at a higher level in the tree.
> 
> This patch is not introducing any code or functional changes, just moving
> files from one location to another.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
