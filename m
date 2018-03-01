Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AG47ELtwYg235b8NqQd96cfa9jEUia1YmEB8mNfYjODnrqxpRVTtZKifE1GBguXw14NHTO1l2hAP
ARC-Seal: i=1; a=rsa-sha256; t=1519888767; cv=none;
        d=google.com; s=arc-20160816;
        b=kZEUz2gawAiBARqlHIiWixybDVR6epP57jazttqSwf/fFsU84FlOmRgDU+hz9B9g5f
         Q/YEMGh2ZnWckR94CDCqPU69TimS7ByAXHn4GvO1a6Wx9uhwSUcc/SgR4wg+UuSNn8Fo
         BZihIWMhcIQQ6M/R9cpwgDZcJHGRHk8WKJXC0LRyVIE6Ihnyu7zvnY//OfolEbCHBkm1
         KV11wMXa5s01Bte313/xKiCc+ipifruBabwF42MznE/455LjCJeJNkD/PZfgg6TLGVf0
         wuzdln6YLpRBIL1OgbElPmeixlq4zd2fb03d+l1f5JWjzhVm1FvmVEhPg2+9WPWsepRJ
         L/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=CyZSwi2/0x/8EiyglYviM91JsZLSh2fH4SGtkJOvlhA=;
        b=YKLskOM+OgUlx1sLL71YpxJyVJ440kG0RVgJxvKks5sNDT/wXBFRnx+84vwuM9MBVk
         aWtn0lG45ASPkA2a0flNvdXd54a/Cwzg8iwOAU/Cw6aA2kQJJSvZQvg0YJb6mIq3fGZf
         yNevqyQwdpptLLYlkbK7k8umfzkcYUmJYmop46DaEovP4k8LTujJDFmf3XMkmyufgIAO
         8MbKIuNxnHzHoUpF2Y84A2s6frxde5J9sBexYWLotLtYgD9d+GYHmoqlyUGRfGNpOJGI
         et97TK0fUpnXBGNS2HEMQISqurFIlXrAsSRMlRiFFafnaqCarHqnDxW3FQmOfyCou70l
         JCGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [RFC PATCH v4 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH
 and CONFIG_XEN_PVH
To: Maran Wilson <maran.wilson@oracle.com>, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, roger.pau@citrix.com, andrew.cooper3@citrix.com,
 hch@infradead.org, JBeulich@suse.com, x86@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
 jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
 thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@linux.intel.com,
 davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
 linus.walleij@linaro.org, rdunlap@infradead.org
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <d64004a7-24d6-51b6-e125-23ede76a77cb@suse.com>
Date: Thu, 1 Mar 2018 08:19:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670432609567761?=
X-GMAIL-MSGID: =?utf-8?q?1593718883870506608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 19:27, Maran Wilson wrote:
> In order to pave the way for hypervisors other then Xen to use the PVH
> entry point for VMs, we need to factor the PVH entry code into Xen specific
> and hypervisor agnostic components. The first step in doing that, is to
> create a new config option for PVH entry that can be enabled
> independently from CONFIG_XEN.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
