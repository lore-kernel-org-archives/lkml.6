Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x225MGd+6YzLYw6QQ50j48hgg0YyR9zJZoWgsCUaFheojQXUbiYtWWV7HHFZ4NbyX6YQ7kCBC
ARC-Seal: i=1; a=rsa-sha256; t=1518786610; cv=none;
        d=google.com; s=arc-20160816;
        b=ZYpgDH4+x8xvm1tMryUHEqZ2dTEaHX4BkNJlL9jsLPLjJ6WS4JvTwZgS+XtI4nXn/V
         2uUu8Qdp9accZmaJDIQGFNtwJr2jvTUzNB0fE6NRhvN52lGSbmE/octsq7sFKe+nGcWQ
         Y3aMOfm9nTpMMG+wxTQANmQT7+HM9HVmgKOgb5zUAizTo3QWFFHZYuzGFcN/UH/BiW5F
         rtDR4jEcGKKrV4g9dnj1gesPjzfU4h+Bq/aN+CqRkSBmtYOeq2g7yVxxieA4HkT8AhRw
         LBrOaG/11eF3VAPBXZxw8Rle/6X393pHiFx1rXCyRlg5u1e/eMenxQCa0z5atMPqmtg7
         vb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5zDvLDsbR+ypyOcqAmV1L7nsJI37jqYQFDHcv2w1fDY=;
        b=jR6uq4uwcs0APjyS/Xl1zKxOiTjgBAFkZj7SQyqeHqNnJzJPF2hS/dzAc7c6F7RHiJ
         8QpfOxMsPofPhVwdRZ2ekPHnmhu9VrlX2zjMkyIhXBA9dYTqsiwZxrIQdllqwf5LlkfW
         xN7BmLU4ldPDoDlycthUTafK3GUqGRqgSgJjFLvoxdHbioeyo08flN1YHwb8xmaup0O/
         uKCDMh/ypRBLH34m8q41CIPCTjHb56ddwLI7koss2uOLGsFwivoDMK3NV3DsT4omhxH/
         mLv6YeSo+UcWAAxs3NIMmYnPM+xoSnbEK9f0puiMYxd+iv0sl3hGKgY2gzdQsLJioSQD
         QciA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=VbldgOhS;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=VbldgOhS;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180216092330.k7hutkvjmy7nope3@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-4-pasha.tatashin@oracle.com> <20180216092330.k7hutkvjmy7nope3@gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 16 Feb 2018 08:10:06 -0500
X-Gmail-Original-Message-ID: <CAOAebxv6iJ=iz4=J-d2XHwXxF-CFK1Gs_W7fDLcF9yoV=av_uw@mail.gmail.com>
Message-ID: <CAOAebxv6iJ=iz4=J-d2XHwXxF-CFK1Gs_W7fDLcF9yoV=av_uw@mail.gmail.com>
Subject: Re: [v4 3/6] mm: uninitialized struct page poisoning sanity checking
To: Ingo Molnar <mingo@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=736
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160158
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446423253504?=
X-GMAIL-MSGID: =?utf-8?q?1592563188753319982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OK, I will update the title.

>
> Please always start patch titles with a verb, i.e.:
>
>  mm: Add uninitialized struct page poisoning sanity check

OK, I will update the title.
