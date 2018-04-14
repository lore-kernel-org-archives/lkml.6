Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48/kfKrRJTgKxOWvmyCcj93SSybnVjPzdCve1rMcy2DfeWiAI8lZWxj9fWmzMzfjV7EwGqS
ARC-Seal: i=1; a=rsa-sha256; t=1523726919; cv=none;
        d=google.com; s=arc-20160816;
        b=oycEZHDULB7v89+hTEe6GkrVZBDoDJvNzTdsZvYajBuDgdCqFZLy+x/zh1iaeUbGz5
         YnM+vSGZv6VnJjoF6ryfK2gQ5z00gRQpCrbyA2JzBWG6u5EVAvD69V/L8DDWNXlDHHDe
         M+jUiRM6Kp9yxd+NFx9/HmwuGnvT8biuzUU8xozeWhaRntHYot2lvM7n5MmNT0f5WG1n
         wASnFdpOO4Lt9AmZRmu9Bt1Um50ARHZNYQzwTZeT8OMGP5OTIaxMkU/AV7R3ncCWICGt
         Oe/F/SRJCCObhcPJ/42XnSvBt08yly2rS4pYqYzjWoXNmRvS8xIjRvzDQkGgwuL6H8i8
         aNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:user-agent:in-reply-to
         :content-transfer-encoding:content-disposition:mime-version
         :references:subject:cc:to:from:date:arc-authentication-results;
        bh=s5l7KJgk4qIXSEvspifoBWsLRtCc08nAi0ZzOIiytQE=;
        b=zUBqKMNXeC+6nShihS6T9PVufP0a/wwfjRojL4pJysIFDLIELQVPfBQ9aAbb4H6cez
         fg2CZiNYw4McyRODmKqx9NL+nWZjac+JdaHEJKW3LQ6eWKi1/UaExcgYu/PtCr5Vkq4h
         k5exYTnU+x6g3BfrG+Su3XMmhPtEUQplssepZZ0WUTzlc40rwjm2dhSyhxM+SRf187Jn
         rFqQPIfFbFaG/PWe6XYu5WdlEIK8vpB/Rsc2jnxIE+GpiAtxJQj1QTivNnCoc7RIVPyj
         18sv6k9oIv65HLxIzsc1zQzPDG6WgqKtFu7HupLcBdtucDY1cC6tayN3s8tr/T85Jzbg
         CdQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeDNR2i (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 14 Apr 2018 13:28:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751154AbeDNR2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Apr 2018 13:28:36 -0400
Date: Sat, 14 Apr 2018 20:28:27 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: shuah@kernel.org, aarcange@redhat.com, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests:vm: add include file
References: <1523732936-42546-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523732936-42546-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18041417-0008-0000-0000-000004EA8F5C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041417-0009-0000-0000-00001E7EA08E
Message-Id: <20180414172826.GA3211@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804140168
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597718514051062643?=
X-GMAIL-MSGID: =?utf-8?q?1597743478896471635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 03:08:56AM +0800, Peng Hao wrote:
> userfaultfd.c: In function ‘hugetlb_release_pages’:
> userfaultfd.c:145:25: error: ‘FALLOC_FL_PUNCH_HOLE’ undeclared 
> (first use in this function)
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index de2f9ec..d8fe447 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -68,6 +68,7 @@
>  #include <linux/userfaultfd.h>
>  #include <setjmp.h>
>  #include <stdbool.h>
> +#include <linux/falloc.h>
  
The FALLOC_FL_PUNCH_HOLE definition should come from #include <fcntl.h>.
What are the versions of your kernel and the libc-development package?

>  #ifdef __NR_userfaultfd
>  
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.

