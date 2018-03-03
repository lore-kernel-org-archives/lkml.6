Return-Path: <outreachy-kernel+bncBCINLKMVUUKRBS4G5PKAKGQES7KOJQA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520091980; cv=pass;
        d=google.com; s=arc-20160816;
        b=xLGg9Uuu2FROa+OpStReSIcEHkJgt0mveTYQFIkpW7+81Zn2MAVHPnKqew5d/JRWu5
         59i+z88ohu2zsKOe9r5onKlQC566EO4ROfaw9njwknxydIcNPlURnXGknzfF942QoQUo
         3Q58VKmEUKQ8d3nAyRA4oT5CbywdAlLyfP+ObuVWtl45g6gFyPKn+cEBUDzYuzaTVOB2
         Kad1SNvmVCjANyr4pg5/zPIynQDPzOdpU/JZXdJiadVLBCUQzr3hO0u5hpXtZN5EcHIq
         ax/GTiXQvz+t4tF1NeQZcuTScmjrIOoXxcZ2P5G2H+KN/Stb6yNMu3mGcDx+j8VaYxNl
         s0Mg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=CtHUcmBT3ABIAg5VXIdpeU0sS/pW+j+Nigwl4ZFKXIc=;
        b=F0OO5H5WpSfgKqFQpo7novz0yBZBofOxLPdFbTcJp7qrbS9N/tNILvRnUtJa4YJzE1
         I/7LrwQXJddgJQBvqnCJw3FTm7XGhTzcMXNy2rsqjKWmWx3NAKhIwTOEnVf3oL7VAcAN
         ZQNn+Cne1r3u3eKWrevpL5wLEkLyRGo2Qy/QOb0JjcRhrqWAev7Wb3hxwFphDl+VtsWt
         14wzB5fObDwN1kRuTOtYHQP8yX6GTFzhsbm+0JaDGhATLpX1ZvcYWxgn/MHtQ+GHR1sp
         TzuECvFbgUUoCbFhsS8cfFhoCOP6Zei24xB2sWhD/JZkZyChYtfdAIl1m7NQunI5+e4D
         ba/A==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=nvjTrmq3;
       arc=pass (i=2 spf=pass spfdomain=intel.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcinlkmvuukrbs4g5pkakgqes7kojqa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCINLKMVUUKRBS4G5PKAKGQES7KOJQA@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=nvjTrmq3;
       arc=pass (i=2 spf=pass spfdomain=intel.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcinlkmvuukrbs4g5pkakgqes7kojqa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCINLKMVUUKRBS4G5PKAKGQES7KOJQA@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520091980; cv=pass;
        d=google.com; s=arc-20160816;
        b=smhIe31IJZJNJ8B5P02qXKoOFW8Oo+bFayEVKQ5KCT+YzGsyZN8YUQgYf2QRNttrpD
         xERogwhy7Ociy16Yp807Y9VV3Reh/vABAZUzCv3Db3xmIfEwgRt7iuCCu4h5UZepjnEQ
         miKsQKYMCwEP/m88BnjANv4NULxoSCfhT7KR/xauEkxa8N30V2q8pAff6qFQLzOcoC2b
         1iGkgjEsOlx7qc+7eE0fMNRk9LKFeFH6TEHcMIkNotRrCCS6Ws6wA5dSyCsjal/OwE5z
         mW7BsfyV3jWBgnqIqbNDQNlkXjBlOb7yoVq8GUU2yyAGf4L4glsilkjF7dmO0AYRPI+V
         YdDw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=CtHUcmBT3ABIAg5VXIdpeU0sS/pW+j+Nigwl4ZFKXIc=;
        b=GHqqvE5kqzl69gnX44pX7T3e5uHohdEqCbsLd5giOa26iDUOELh6bCaZQquR6HaHIu
         7gZJwcWyLoMftJe0pXEWVMq1emZ/1gcIj64v82JR6ScTCplCs00osG0IO4lrVIpdjncd
         nn1o8OJR/lj6Anv99CbFWmr1Ao2INQ29BR9eW+6ypD/REZ8fCZVTTgVDGWRnFTB7KX1U
         XzU8kSvG8W4FZ5PsGijR+ASYeDVjOY6xL87D8EvrbTxEs+pBevDON+a7i9EtJpf2nKRy
         Cr3ZxGeP2JUR/d13WyxI951qvelfvAbMVBjnXllVsg1WxoYHwDJjwGnZbz2rIkif3x6I
         dlUQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of dennis.dalessandro@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=dennis.dalessandro@intel.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELu6D/2IC/am0To+Y9Hibbpm0Rf72mkdhigC8BYYH/2Fa0qrzs3CHFl7egJd2LQL9VY1UMpMCw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520091176; cv=none;
        d=google.com; s=arc-20160816;
        b=gEZU0IWwAmQ5EtNQiFu40ThYii8b8G2zmOPqg7HnvPiJ10JyDonN4PlS4zq6zGeS5C
         0UXuy7Cj3Se2XgCdpU/HaadwKcM+KEeKDirrn/YsN+coxJlornczoQYMTU4euX9uRfwY
         Cqj3uJz4WNb2IAWAF03fZNYyKK64IRxEWj2SCROv5WKyigQVnt1s+qm6gmkGn+9DODvq
         hJ4shwVUkojyh0CZz2d+gfV0zADyvJOBSU5SxOQlU3Lp2vKKbf4wV19LaZrDCMbIQlxw
         pefUMqGPlJEVusVmqFRt60vrKfXuKh7emjtDE8J7X1Pk08scg5Arn0ASBtTnEpyl6hHi
         Yf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=szlQCenMFtc2IThlmJ39Ep7QLQigcIiyKIFYka79wqk=;
        b=ekJM9GeTN+UMysBHAOsnH5S3YmvME+vzGJXSAF2LjmztCd5rbrlGdigS+SFNdY/z4s
         TKZxVKAqmWeeWXS2Mu/TaqlZ/g4s4le/AK8XdDp9KHskZRPri8LtiT3wWXxurrnG/h20
         rBX5j2IH542EBLk1fguR4IQ5o4WchcenTPkcoduSr4MASI8SkP9+pwo4eBn7BiBv1NdQ
         t5v96AQn2QZCRigQofc7BX4GYmIAfPA04/IO+Qj9e0jSjxhD+i57p99GrnE5I6TKT0jv
         lodephsXmbyynqIQuVgN0z5igj8h7A9qmuDMgtprSsLhNBMqOqORvUGKrwsOfvTNnNqp
         roOQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of dennis.dalessandro@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=dennis.dalessandro@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,418,1515484800";
   d="scan'208";a="21612604"
Subject: [Outreachy kernel] Re: [PATCH] infiniband: hw: Drop unnecessary continue
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: mike.marciniszyn@intel.com, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <20180303130336.GA8210@seema-Inspiron-15-3567>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <8758a94b-ca48-7b82-6192-fd7ad6a515e4@intel.com>
Date: Sat, 3 Mar 2018 10:32:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303130336.GA8210@seema-Inspiron-15-3567>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
X-Original-Sender: dennis.dalessandro@intel.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of dennis.dalessandro@intel.com designates
 134.134.136.126 as permitted sender) smtp.mailfrom=dennis.dalessandro@intel.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593921759797565624?=
X-GMAIL-MSGID: =?utf-8?q?1593931968614677992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/3/2018 8:03 AM, Arushi Singhal wrote:
> Continue at the bottom of a loop are removed.
> Issue found using drop_continue.cocci Coccinelle script.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>   drivers/infiniband/hw/qib/qib_init.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
> index 3990f38..1bd3b32 100644
> --- a/drivers/infiniband/hw/qib/qib_init.c
> +++ b/drivers/infiniband/hw/qib/qib_init.c
> @@ -681,7 +681,6 @@ int qib_init(struct qib_devdata *dd, int reinit)
>   		if (lastfail) {
>   			qib_dev_err(dd,
>   				"failed to allocate kernel ctxt's rcvhdrq and/or egr bufs\n");
> -			continue;
>   		}
>   	}
>   
> 

Please run checkpatch before posting patches. This will fail as you left 
braces around a single line.

-Denny

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/8758a94b-ca48-7b82-6192-fd7ad6a515e4%40intel.com.
For more options, visit https://groups.google.com/d/optout.
