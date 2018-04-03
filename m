Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48IH3lTJH/bpxYoCSyf2oTL1iJxc81SBJR9uvD0sLD+LDwFmzCo/gdEE9j0IHnTX684YO1u
ARC-Seal: i=1; a=rsa-sha256; t=1522750046; cv=none;
        d=google.com; s=arc-20160816;
        b=qHUYGxH2i01z5v/YK6i96U3MV9501uFH98aGlXuyp7lpN2hFF66/Ox7/rFCuhF22LV
         KEW4u4REcb9cEzbRgqO4c3+lW7suA4ksGobnb3Koo9k1n9iz1OMwaPE3u6y9ZCJzlQWl
         mdAOK99heWvuZ1H88ZN40gsm5aomqnkjV0ryQPoniswkEaerTWYph9CdYXL7VMV+MPMb
         nm7in+PBilg4W1RHTYjrxq+kKNC+4pXKrL2i3K3HgdDXKmUdNCGBviKD6NlX+DuN9FxV
         TgY9k7Dk4jnoxpHtwwp27ubRfksJejTYKh+Fr/J8HomOzcGQP2cXtmImxT5GnNnbVCR7
         PTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=GNyHh7JY/IcC8SiXzk7mtXcnIhr9I2MfHICqT1rcZck=;
        b=fMTg12bdcmSJe02732uzL1F5nNnnXVykSJ5JAW5ZAEmI2PASLQQnRjnRTrcVqSRFJ2
         13KN04Vhw60S/ltqFB7hAV6bYnrvc0AZt3Q4xb0Svkf6I0wDzG8EjybDdJta6ATBRMgr
         Bc5DjWjNiLJHWG5+v7OLU+QGfVgRb0KGdKC5XTu4w1sCJkYuNeB4ZsTgbzyh7uyWzyrp
         /aZATPbT3uLgDi8EfSrhGB/loODkecx9+9WsXSGLKVo9ISVeK0OI9swLc94Vuy+h6ZDz
         IprV2oJpXy0CB7lX2nb5LJ5um+J3kjouGxjdK6wZZj173hAJj8MkloStk+vBONKNUMHm
         yNJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=gU6S2EPO;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=gU6S2EPO;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeDCKHZ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 3 Apr 2018 06:07:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46126 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeDCKHY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Apr 2018 06:07:24 -0400
Date: Tue, 3 Apr 2018 13:07:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
Message-ID: <20180403100704.hwdugt2piatcngqw@mwanda>
References: <20180329172431.8171-1-colin.king@canonical.com>
 <20180329133102.6061ba66@gandalf.local.home>
 <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>
 <56713d51-0954-e7a8-cf7a-7a6bfedf58f3@kernel.org>
 <20180329140409.1311baac@gandalf.local.home>
 <583c21dd-2ffc-4375-af8a-aa721ffb4594@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <583c21dd-2ffc-4375-af8a-aa721ffb4594@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=651
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030109
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596719152477966885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:51:21AM -0600, Shuah Khan wrote:
> On 03/29/2018 12:04 PM, Steven Rostedt wrote:
> > On Thu, 29 Mar 2018 11:54:28 -0600
> > Shuah Khan <shuah@kernel.org> wrote:
> > 
> >> I will pick this up with your Ack Steve, unless you want include
> >> it in your pull request.
> > 
> > You or Janitors can take it.
> > 
> 
> Okay we can leave it to the Janitors then.
>

There isn't a Janitor tree...

regards,
dan carpenter

 
