Return-Path: <outreachy-kernel+bncBCUO3AHUWUIRB7WK73KAKGQEUM3QC6I@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520412031; cv=pass;
        d=google.com; s=arc-20160816;
        b=V9O3HyRCp3qYKOD5IrcnEeY477rfW5F+s1oj4U2hxAblFSXiSyK2gyZYLfoQZG0STZ
         NDHTRoRf/pvglH+yPp3w001ZnagWkBhIjQCR5rci0viIqi0GE+BHnC0p7LpcyVl643Ho
         ZIYPQ6wYFw+0Crpadsg7BKkjeteRQXF+gleFlNQ9YUCkSbM2BErb4YXbO2d0ECZLOrl5
         NfwBkPJW20GVa1q4qmMTOM4q0fFZ/KSV9bj7RXrZNajqGNw9QlmaWWPmldKmN5YK7cIU
         gwDPWYUUMntnA4Z+q/202SEVIqboUSFFu3CmBUN6rDDpuOOkqLL9BBBm/hD8IQGbxawD
         Tp1g==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=XIBPJr7NkAiPEZTgGeWkpE13lJItRKTOeAjdsFw2vlQ=;
        b=eYt9aQq2wFrUQ7tz4IfWDrgoWap9H56QTW4HU56Z0CXnpNXZev2ZtyTFCkU5IYfY9Q
         CxQ/ylKQnZ4If39B/P8OurLhS56f+Y+HwKqGt4W47HPCkcHM4Lqydm8wUzDMFYJy65IO
         weSt9+NK+BbwjoW0Fzdf4dvpEV5xTgv6ooP6T9g45Uv4b4dc73HEgynqrxVv9cPywNIs
         M1sdMF1xvDuD8HroaWJVvVx2QW6ocJl1QaQMDBkcj1lly/RI9uPYJxP5Qk9M5c2KgZLv
         ZpeR4zuean0AWre9g4Kv6jQT/YHCCs6CFH1Ct1vNX+kww3bgIo24Uxow9bBy3RwLJrVs
         4B5A==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=VgHEBVOM;
       arc=pass (i=2 spf=pass spfdomain=ziepe.ca dkim=pass dkdomain=ziepe.ca);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuo3ahuwuirb7wk73kakgqeum3qc6i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUO3AHUWUIRB7WK73KAKGQEUM3QC6I@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=VgHEBVOM;
       arc=pass (i=2 spf=pass spfdomain=ziepe.ca dkim=pass dkdomain=ziepe.ca);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuo3ahuwuirb7wk73kakgqeum3qc6i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUO3AHUWUIRB7WK73KAKGQEUM3QC6I@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520412031; cv=pass;
        d=google.com; s=arc-20160816;
        b=YHl1XwQ1mABdYlQax22mnfXSfsOlEnhlDnRrhb4AlIJykuDav6u/1D33VocwdfQZL1
         SKn56xsFKjViB0qH9iR7IDHWURM3x/Kus+W6RhSHSFxwm/ZmD1gNu8hfiHfE5XVrcg+t
         rBS1xaJB2IoP7HcHbRAXsd7xrYlT5LYK7jCHJ7eimXs2A3LgX88I63REvit2G1Pj0Qgt
         ao0U/aVaHj0lPrEzbqurdvUrCODHYb8HO49XCUyCYwk+BjhTTFHUEmQeoGdCOSJaeSsG
         JCnb2WPHY1SWQqzo4+Jqi4Y8Hx3SE4CeD3d8tK1/Z6bQx2VW9XVtTcuf1YosuIZYHrXh
         Iquw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=XIBPJr7NkAiPEZTgGeWkpE13lJItRKTOeAjdsFw2vlQ=;
        b=uoHBGi8ZIGrslmjB5rnfjb+VvjTAKEYrpJGg4thCP2EOC6K4Fo+WyAFUj8O08eRuTM
         Ef3P9lpTw1/QBQaQ3FkfllwDD4BTEwxWkz+/ibxH1CC1aIhVbrKYgml1IddVXK1+xRu8
         kKKYSMgx76P+/GQ3qRJoOD/WpRYKmZD6GhdTNkrt9kiePLtIj187djm/4pSHer5fu3em
         7dalt6KTFpv0TiAx/UUH2ao+2Tj1ThFrleKMx/xYNvi93XX/N1pfsysI12ykJqD1iUfa
         KLfwRgQuuBXW/SuBZjclHEvmeRqo4bR9ZY1By/KeoCNY8lraPoW5XgUEAtdpI30tdQrw
         6DRw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=QG9ETXz9;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 2a00:1450:400c:c09::241 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsyz3xej6rchPpQYMLKoL2aj1udjpcs8lhdK6/y5BPDoFBXWnTJr39Xhm/KBdc5+AFpP6OLgA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520379309; cv=none;
        d=google.com; s=arc-20160816;
        b=Ye9q59ZcS1vOA01xvOhucr3Bq2yRUZToVQj4k+adpCjo/Idg0Ybu5mCejlnOGTI+J9
         N/Xz0JvuE+v46iYNj8TJV4UuGp6BehZJJjEhkDP/eGcTYN7fW6pcBLQG/9i8fBJjrvdW
         aAXObWEF6fGLXmVObw7Wstl6G7Arn/eCRTuDmaPSiOCdYxL+96a9MGohud022smrIUxA
         vejZL5SRgxiXTaVjVncQx6qX6xx1dY9YizM3qy7TeXykJnM5mVVWh02DevTYEU+2OShF
         1RTzyI9awsBaoWawWAfB1tNgT4RhJIJWyN1GF/sIUkDALGHvCXP0RA2u5lY33V3k4Aqr
         x6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7kbE0xUoEbyzRI2viRsSR22r9eevLw94V+peLncbY1I=;
        b=bsXL05Rq0PHzUjsMmzwZauIUTn/IFUADUM0shpmkwGaSspFbPtfKTigrEoOItlSz1J
         lnyrdkyGjqsTk0GYaWYrGtV7WXCkgsuTH2lb+QSGEwVCpRMUtqJfldX/oObb7KoSBPW/
         2Kd1hH3/+6E39JSVGjTLMFaZyYv8MRe1eHSWaf4O8ZR+ktftSCEfvs1yV9ZF1G9wB2Ys
         +VuVN695+WXQYhydInI1el7s29WEM9/qRKfBA82gkRK6h00bzHBIdptmm3i4gcFCHXdH
         sHnzwrLqV8KFjSaAGaAC6etrphUI9Q4zFhVxpIYenATHStZFjyhO4tXdfCemFYxFtORH
         iXWg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=QG9ETXz9;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 2a00:1450:400c:c09::241 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
Date: Tue, 6 Mar 2018 16:35:05 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arushi <arushisinghal19971997@gmail.com>
Cc: dennis.dalessandro@intel.com,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH v2] infiniband: hw: Drop unnecessary continue
Message-ID: <20180306233505.GD8328@ziepe.ca>
References: <20180303162457.GA21730@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180303162457.GA21730@seema-Inspiron-15-3567>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: jgg@ziepe.ca
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@ziepe.ca header.s=google header.b=QG9ETXz9;       spf=pass
 (google.com: domain of jgg@ziepe.ca designates 2a00:1450:400c:c09::241 as
 permitted sender) smtp.mailfrom=jgg@ziepe.ca
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593934427022927872?=
X-GMAIL-MSGID: =?utf-8?q?1594267566292365259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 03, 2018 at 09:54:57PM +0530, Arushi wrote:
> Continue at the bottom of a loop are removed.
> Issue found using drop_continue.cocci Coccinelle script.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> Changes in v2:
> - Braces is dropped from if with single statement.
> 
>  drivers/infiniband/hw/qib/qib_init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

applied to for-next

Thanks
Jason

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180306233505.GD8328%40ziepe.ca.
For more options, visit https://groups.google.com/d/optout.
