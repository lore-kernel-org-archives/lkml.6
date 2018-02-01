Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeBAShG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:37:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752580AbeBAShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:37:02 -0500
Subject: Re: [RFC PATCH v4 0/2] ima,fuse: introduce new fs flag
 FS_IMA_NO_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dongsu Park <dongsu@kinvolk.io>, linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>
Date: Thu, 01 Feb 2018 13:36:53 -0500
In-Reply-To: <cover.1517314847.git.dongsu@kinvolk.io>
References: <cover.1517314847.git.dongsu@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020118-0008-0000-0000-000004C87F07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020118-0009-0000-0000-00001E5C1ED5
Message-Id: <1517510213.6675.12.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
> This patchset v4 introduces a new fs flag FS_IMA_NO_CACHE and uses it in
> FUSE. This forces files to be re-measured, re-appraised and re-audited
> on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
> cached integrity results won't be used.

Thanks!

Mimi
