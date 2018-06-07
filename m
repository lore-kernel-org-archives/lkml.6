Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 71xDGn1RGVv6DwAAmS7hNA
	; Thu, 07 Jun 2018 15:39:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 007AE607E7; Thu,  7 Jun 2018 15:38:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 75A33601B4;
	Thu,  7 Jun 2018 15:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75A33601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935452AbeFGPi5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:38:57 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:43765 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933193AbeFGPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:38:53 -0400
Received: by mail-it0-f70.google.com with SMTP id i9-v6so8165403itb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 08:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=0M/fXvT78lIcsKcjUMbL+7c5TkMF9QMbAsWAjrc249U=;
        b=eZkAc+VDWCFvyOrdU0u5OOEXZ9azj/5+aasCkairl1wULYhXiU/FRGJIE9pHMUziVg
         lHMen/AbL2nk/bIGg7xnfbZ837kR6H5eqetJNsTFtrXRDfry1PzE9u4qULYrGOZdFycx
         WJ/wDtb6HkBGKSdGuS3Coxg8ItWi0+eIbTnC9e8CNiP1w9LaPMl/4jMS26tX5wKkmllG
         w7Z77pvniOaIc6z6dUqQwIXCzWWLdkllnHBI28ATTGbZ61SlmxN1KZinpwRaBZPetNux
         vhwPYpN6hYBGTuksaMJQKCOuSxjCmvC8BNSm7xepEUZq7qV9VvKe7SiCBJoiTXizXSYK
         U9Tg==
X-Gm-Message-State: APt69E13UDGy/1QLC3WXwzsFvrcudRGydaUu2K0Yj4QCyN8NRIU1qp6Y
        4KyP4ReejrTZhFIMX0TnIjmdbdNP2qANfiFNdkZouxBpAI7t
X-Google-Smtp-Source: ADUXVKLXVKUrjv9DxtYSEmxQ8qNpf3Tf6ZnMCDHfzy+1CQBRkfYaXObm6I/zy+tvejuE50PwZ8ikCHSnzARjus2RYzSKRxk2uqJM
MIME-Version: 1.0
X-Received: by 2002:a6b:700a:: with SMTP id l10-v6mr999556ioc.60.1528385932836;
 Thu, 07 Jun 2018 08:38:52 -0700 (PDT)
Date: Thu, 07 Jun 2018 08:38:52 -0700
In-Reply-To: <20180607183627-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b46ec056e0f1460@google.com>
Subject: Re: Re: KMSAN: uninit-value in _copy_to_iter (2)
From: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        edumazet@google.com, elena.reshetova@intel.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew@mjdsystems.ca,
        mingo@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, virtualization@lists.linux-foundation.org,
        willemb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: https://github.com/google/kmsan.git/master  
> d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617

"https://github.com/google/kmsan.git/master" does not look like a valid git  
repo address.


> Subject: vhost: fix info leak

> Fixes: CVE-2018-1118
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f0be5f35ab28..9beefa6ed1ce 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct  
> vhost_virtqueue *vq, int type)
>   	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>   	if (!node)
>   		return NULL;
> +
> +	/* Make sure all padding within the structure is initialized. */
> +	memset(&node->msg, 0, sizeof node->msg);
>   	node->vq = vq;
>   	node->msg.type = type;
>   	return node;
