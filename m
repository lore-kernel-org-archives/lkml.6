Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELu/MNfYmDMBT+r9zXHzRY4LN0pKPz4xNJuLhjyjxJkwIDYU5mN/zZ4hl7VyL3RMSwvMCQZ+
ARC-Seal: i=1; a=rsa-sha256; t=1521646520; cv=none;
        d=google.com; s=arc-20160816;
        b=rrwRwovxEXlwGCoeqExKGr/Xu/lM4EI2sT7GxH1pLeSggirl5gY9syGeHKFfsE/dCv
         znbw5xGD5HHlJWoaaLtKQv8cCB4v0iysFbWkeqmlaIx7K1qwCfTrPHWZiLmba2mxIXG1
         sngeiWN1pIfdyI5sNtqMaXfvE6Cu6flIn4mE0VqDsujNN1qI+lJNhvqD00Te0tPL29Um
         6cphD9E1nw1zPosFJ0gogiYu06t/lbX5k62qEJf5fRl/UuyOJuoVpDixIoecnIWU7WLW
         Gt2HHiXaXS6XyNx61wtA6yQc780bzeWDBcIJHZr/HTSIrwevdSVkFOKLwx+RDd+707hZ
         Aglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=4+PG65OXoQE0WQJqYHuO7peGJIcZMuQVwM4x9RqSY90=;
        b=LsqpSvlNdXi5PbC97qQuE6ipMT9nwaL0SyWvuKoT9FupIGX5Piod90FaN/VWtaSr9V
         4dxl71ryaA6ei5YRS39jpvdaScseb7EgUTnrnCQlahjPFoXxvUzpJEZRCwC26y5/yYIV
         QUNKlwBTM450scZMI+auBY5FwHzc0xcpDtCVqjCWg7GQeptpqFWU7hXM0Q28EHfLCJKX
         coRWLTWhvkvEQsZCrYyrMy1KU991qzs0nfCyyR9fejIMl3yjQcbu4v3db3Ps/pEjg74T
         Y2k/NLalKJcK64I8U/ZarLvwNDvBMe6Bk6Z5prRMqW5X/cJzo/ZNOvxVb1IJeg3E8ZkH
         b5KA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 21 Mar 2018 09:35:18 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH
 <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] Input: trackpoint: document sysfs interface
Message-ID: <20180321093518.1fb9572f@lwn.net>
In-Reply-To: <20180302173019.GA27660@mordor.localdomain>
References: <20180302173019.GA27660@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593847920660863123?=
X-GMAIL-MSGID: =?utf-8?q?1595562021999910388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018 23:00:19 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Descriptions have been collected from git commit logs, code commits and
> the TrackPoint System Version 4.0 Engineering Specification.

Applied to the docs tree, thanks.

jon
