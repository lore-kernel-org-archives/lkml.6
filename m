Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsG9q8oOv0o1sRxm4SNjqfAzme6acrCNjQulqAbdIZFBFrplpZFAbCloM532vgSTYFRdtBS
ARC-Seal: i=1; a=rsa-sha256; t=1519998123; cv=none;
        d=google.com; s=arc-20160816;
        b=uQ642pLWjVASVdiqOvWyZY2dTlqYy9GA601SAUDuILwcv5jrhPT+KFBixYzU0/9Hbd
         za4AW0fIfsgyV0Pp3k9BwK8zB+XLmhYrsQLb1OOT7jlr6T7Y20h70uX6OaeBAPCIpW1L
         wNPFFm/JPnm2Yni4QmIaGX3z2DmbB38O79qDeL3f7UrgA4Btu1fUxowQwoy1AjqYxP+o
         Zj9qm8/5L5E7ZS0ycWBPFjNdB6fOjTv4pNOdNAMf98tP3IEPEK6VM374WUUilZr4Dkpk
         LBZH8idj0WcBVTfNakDOUUyjAPtPA2SLhrkM75Y4lpd+9lZeDpo9pw0ZICM16zEGtl9M
         jyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fl/mH639Cx4q2vA3irCeip7xqUAbuUvamEi7vjjfhFE=;
        b=wRZHwbwbKlqNQDgOzadtlhxpcwcDQhTjpwo1LRQlIjEQzfE9uOzhKLfkJC4zGcaGev
         ocYIn+ikJkAuFvtbiGdLsgU7e+vTalFxCviq+z5f/rWpRgI2z2vEcfLFMt2a0bU3YqQL
         VPUMR9K5Dr9dv7YpzckXRz3WAfwMfcfkJZnpEhavc6rliigjSD2iEs9skdzIK1rKvonz
         oG0M+MFqkFfCV7SpomBlZgX7HGjvjP3073Wx9aGwT7ovVnOljbM7mhG0ow0rkuBKOo3Y
         le8IjUBQcjnhk4lL08Y858o9MTbl89vJg6ku1GdbXSbws3c2esEhVV2TgTt4mWFkRG4Z
         C5kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iJM/Grla;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iJM/Grla;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180302130541.GO15057@dhcp22.suse.cz>
References: <20180228030308.1116-1-pasha.tatashin@oracle.com> <20180302130541.GO15057@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 2 Mar 2018 08:42:01 -0500
X-Gmail-Original-Message-ID: <CAOAebxvs0Nh6AkyPJS7e-B-cfeRqUZsQ23AOecOzH8YbneDOOg@mail.gmail.com>
Message-ID: <CAOAebxvs0Nh6AkyPJS7e-B-cfeRqUZsQ23AOecOzH8YbneDOOg@mail.gmail.com>
Subject: Re: [v5 0/6] optimize memory hotplug
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=449
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020162
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593612185598129869?=
X-GMAIL-MSGID: =?utf-8?q?1593833551936654347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Michal,

Thank you for letting me know, its OK, the patches are in mm-tree, so
they are getting tested, and there is no rush.

Pavel
