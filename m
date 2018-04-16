Return-Path: <kernel-hardening-return-13012-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49qhS/AZzrHrHZEQ6cUVOrK5In7rIgu1Zd1YWkIbNuS2kNdOUFhimC7EkSbbm8cAtoXMrE+
ARC-Seal: i=1; a=rsa-sha256; t=1523893897; cv=none;
        d=google.com; s=arc-20160816;
        b=OWUGjvZ3XGYn9synKKcBCt3o3Y36PpEi5I+pam2+k//kRa2FL6HQiJArSNxb0s+nCS
         aksoVL2DeBzO1BwSfDiBkuexwsglvFvUxknoF18zZJNx6lEHuvrF1Hycrj94mn3dwTtO
         edAy3mNWOSzBNvoYqC0UUyKdxOZMNU/fU6aSmir9KHzoEglvTF/w+FLCrCG0NQ4enZ7w
         ZCEe2eFfSd/UpMjeL5lmUy5aont8nmXyBy0YwIUJ/LSVZ0qEMe9GfLGLEQuIzDyxRhJq
         vmdNcIgApTj/8MUilKXz0kedBttkmbvYdqa4RRc89e9ADWgoqTIBBtgq/cUpBFQ4lH9H
         C9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=PWzZkj/oNBm1c9UJVXV8BFp2gDjRhaYW6znQZzfoGkM=;
        b=NKLakDEKrb5VGUqNOpz0s0nxqIQxDv1lsmV8NfMbwVpd+2OT2gi83kiFsazMppAkjC
         6cIizam7tSp1HQ/7Db4nRuhu6cOT0Q7Zwy0RNPKv57XDIRngTYubNo4+U+q+imzAHIVe
         UEoDMEcifyOQE9Y6m4EU7DIQ1zeEnIGi+B6OkCCZUenoNFvOCWfPniA3rwOsNdJZRxoB
         OwxhNmBXtiEPMO2sR++QyaiuKwuDSxtpF/zbLP+zOxs3WQd/1UxjAVfI71sbIo+aWI7I
         hSoIRi12ly35jjWNGU4uovtn1scy6yAB25q83tWbGJl+4Jg4qdzYpHtckepzKJSPWljg
         ItoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13012-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13012-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13012-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13012-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="46573816"
Date: Mon, 16 Apr 2018 21:06:34 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2] dmaengine: dmatest: Remove use of VLAs
Message-ID: <20180416153634.GR6014@localhost>
References: <20180411010216.17702-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411010216.17702-1-labbott@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409665574809172?=
X-GMAIL-MSGID: =?utf-8?q?1597918567468638337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 06:02:16PM -0700, Laura Abbott wrote:
> There's an ongoing effort to remove VLAs from the kernel
> (https://lkml.org/lkml/2018/3/7/621) to eventually turn on -Wvla.
> The test already pre-allocates some buffers with kmalloc so turn
> the two VLAs in to pre-allocated kmalloc buffers.

Applied, thanks

-- 
~Vinod
