Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x227/hQ5BvGDDvSVB4h7Jxg2dR+c1Lu+PoMnt55CiZP4G7W1UecYlsME77ofm8LP0xWKW36lh
ARC-Seal: i=1; a=rsa-sha256; t=1518702156; cv=none;
        d=google.com; s=arc-20160816;
        b=OVXRm4oxrAbGn6PN9zORW7AUuTQyDZOavPppsry0C7nH8pbOkICMTd7iW3WsEXF35v
         9gyEBCQ6M+Hlja1BJNtdwmL/HUkly3OWEAt4qNhAVR9qth1rYhcdoyI9t8raMlMeKpcW
         faDOlbnOTJZ3BgZPulW5xrWzntKwFow+8xCDSzmiGw18BtyE07OuSGW9huh4jZs83fHB
         wh+uep5rL9SXnW8x1w+bZjIqbauAbjawY84wUo2a8NcyfajRCW8sCdcvfJLCM3HbubSx
         O3hSxJHAg3y2eHddUGIfBrIdcvgZIQO4qyUGnDP8/QgZfEBo1kPFde6u2EAB+ro+2bp9
         KcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vTvBN0IpWli3taCo3LKQosgbqkgIlL5euWByujagAqE=;
        b=v7g32zHagrO82WvSLN3bCzFYHicCe4V2TMGIh3Wb5TWz8XU2QHU0BX2WA1S84JGH9O
         gJgSN/dMgBL0GVtcBt2A/PiOpN05A/B03Wi1fILfV/Or07TxQ40TwIYxPQpi1gBmtmf0
         qDSSG8EMtVUjitjog5Rd506Z/aRXFRo6QYLxeIOXEFKNr9ZJ7wncyQ2x7hDnn9RHK+z/
         tvCQsvRQd1z3x2DzQDkBTRcyL5HPG8QWR8xwEM8RV1lt81BCqgQWiWTpYSAcQl2xqVxL
         rSDO21EG/XmcY8kcpCx0+LooR/kYl02zE/Cc23VY/ogsMPF8oat2PoJZliB1/s368I6e
         3owg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=e4k4sdiO;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=e4k4sdiO;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180215115316.GD7275@dhcp22.suse.cz>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-4-pasha.tatashin@oracle.com> <20180215115316.GD7275@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Feb 2018 08:41:50 -0500
X-Gmail-Original-Message-ID: <CAOAebxtS8nHtz+FC034FsTDWrDNtKPcxR-9Z=CkgR4yr2=5YEQ@mail.gmail.com>
Message-ID: <CAOAebxtS8nHtz+FC034FsTDWrDNtKPcxR-9Z=CkgR4yr2=5YEQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: uninitialized struct page poisoning sanity checking
To: Michal Hocko <mhocko@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=684
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446423253504?=
X-GMAIL-MSGID: =?utf-8?q?1592474632451588892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you, I will do the changes that you requested.

Pavel
