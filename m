Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AG47ELtKj9nr9t+cbcIqlKx5f42QjAfi35e9hIn7gK4x+NTA3YUiNHWcv/2ehQAWTXoFatAxQ1yp
ARC-Seal: i=1; a=rsa-sha256; t=1520507316; cv=none;
        d=google.com; s=arc-20160816;
        b=xTaKUPA9liCiJ/jb18mZ9oD0ZCZ6/4hxtXNuDMTYa2M97tH+roahKbccJxy+WBGLYA
         pEDa/dFUzy7J3g+rZw7KpckB5RhEqMiDgWsXIdF/uMEAwZFORQ5T88q6TAmRkZtg7ZYP
         lIDl6i7YLS871Zp7MHc7q18KLeMAX6lCaDAP7NDac6UI1rFH62Qet6j5lH9SDaHvoHc1
         +2xawqJ46lCac9rKWkQxa5FUVscD8UZJ1WQ2vKcn9tBgvU6GDb9vWEaNSHl9S/srbhv+
         hO3/OcVAwtC5ZI3bvvMQ2WPTmvSnNoFyKGw2N6yvlzDSmERsXUinNBJRhjDi8UkR7myl
         XFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=62GBFQpqcXgSL1Gm2Wn8U4H3qb2Kvl3u1KUBiNwrVPs=;
        b=H6FUie6SaukmSAhDMTPfzFR8Ikxm5dD6Zqwza9VezMKuBBwwY1/lMCr+X+PkrcxUqY
         f4XRE8imD7Q6lHSemOFZ3x1dlqTRgvHy3pVvN5z9EsbXhxwQVwQzpwh2k96hVaf5DJvn
         xwAfd9owrL7M5RzkIjwlmRDNX6UVMj0w4fTnYb2ch0mE2EXtZ6oYLETU/xu9sA5hZdxW
         2kkfZRwASeUaumq6oyMRBocaLNji5cGUYNniIH8BqmU7N5IW8X7kyODhpifyNZyL1eB8
         vyCBUfuDDijj6bC9WVNuTg9BhNsT8YVKbhTASqqm+DyAX/k+9J/Ks+vtZHvKB8AdiY4c
         1w1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=cVsQLtFN;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=cVsQLtFN;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 8 Mar 2018 14:08:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ofir Drang <ofir.drang@arm.com>
Subject: Re: [PATCH] staging: ccree: remove ccree staging copy
Message-ID: <20180308110819.v4zfw6iru2tg3ssv@mwanda>
References: <1520498678-32175-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520498678-32175-1-git-send-email-gilad@benyossef.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=541
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080131
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358433276712536?=
X-GMAIL-MSGID: =?utf-8?q?1594367479373705941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Congratulations.  :)

regards,
dan carpenter
