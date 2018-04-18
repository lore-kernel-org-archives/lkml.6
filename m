Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDRP1Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:27:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:11782 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeDRP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:27:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180418152720epoutp01d9401ca0a70dcc7c245774829dd7c641~mkUMD94bx2231722317epoutp01O
X-AuditID: b6c32a46-b85ff70000000fe8-0e-5ad763d7a509
Subject: Re: [PATCH] [media] include/media: fix missing | operator when
 setting cfg
To: Colin Ian King <colin.king@canonical.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <83b18f98-3a78-5264-25fb-9048f9a9bed2@samsung.com>
Date: Wed, 18 Apr 2018 17:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <c554a771-e9a9-fe1f-6792-e73f33b08838@canonical.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7bCmqe715OtRBluXy1r8Xt3LZrH1lrRF
        /+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbPo2bCV1WLG+X1MFss2/WFy4PKY1dDL5rFpVSeb
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVsenqP8aCzIqJd0MaGAO7GDk5JARMJN6s
        eMrYxcjFISSwg1Hi7qdTUM53Rollx9sYYaouXH3LDpHYwCix6dNmJgjnPqPE+VOnmUCqhAVC
        JQ7M3swMYosI6Eqs7f4JVsQscIZJomPGO7AEm4ChRO/RPrCxvAJ2EnfmPwGzWQRUJfZu/w42
        SFQgQqLp+U92iBpBiR+T77GA2JwCjhINq2aA2cwCmhIvvkyCssUljt2/yQhhy0tsXvOWGWSx
        hMBjNoktVz6xQ/zgInH1xTk2CFtY4tXxLVBxaYlnqzZC/Vkt0dnWxQ7R3MIo8WfaJagGa4nD
        xy+yQmzgk+g4/BeoiAMozivR0SYEUeIh8WTLQxYI21Fi1ZHl0PDaxCSx6e5s1gmMcrOQPDQL
        yROzkDwxC8kTCxhZVjGKpRYU56anFhsVGOkVJ+YWl+al6yXn525iBKcbLbcdjEvO+RxiFOBg
        VOLhTfC/HiXEmlhWXJl7iFGCg1lJhHfn4ytRQrwpiZVVqUX58UWlOanFhxilOViUxHkbfM9E
        CQmkJ5akZqemFqQWwWSZODilGhhX7tgyu06U6WjEoginqxovaxO/9Hc1z/j9X4Qxu0khsX7G
        3JlPerX3OdR9eao0/VLcv2nxM3xOlyoZ6jVnp69P27n1beOZhRfm2r1eySFYE5f7zuipieza
        nNDjkvt1onS+7Hh82kqi6935ec3X7O573y20aD109EntDc4nBZf9zn9KllEr3MClxFKckWio
        xVxUnAgAVxXbjzMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t9jQd1rydejDLbctbL4vbqXzWLrLWmL
        /sevmS3On9/AbnG26Q27xabH11gtLu+aw2bRs2Erq8WM8/uYLJZt+sPkwOUxq6GXzWPTqk42
        j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY9PVf4wFmRUT74Y0MAZ2MXJySAiYSFy4
        +pa9i5GLQ0hgHaPEnQU/GSGch4wSL5d0MYJUCQuESuzacZsFxBYR0JVY2/2TCaSIWeAMk8SM
        BXOh2rcwSWyZfogdpIpNwFCi92gfWDevgJ3EnflPwGwWAVWJvdu/M4HYogIREvfOf2KDqBGU
        +DH5HtgGTgFHiYZVM4BsDqAN6hJTpuSChJkFxCWO3b/JCGHLS2xe85Z5AqPALCTdsxA6ZiHp
        mIWkYwEjyypGydSC4tz03GKjAqO81HK94sTc4tK8dL3k/NxNjMDY2HZYq38H4+Ml8YcYBTgY
        lXh4E/yvRwmxJpYVV+YeYpTgYFYS4d35+EqUEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GOR
        QgLpiSWp2ampBalFMFkmDk6pBkaWw0ENi56aaWm/c1RL9yjtmTn9jUZjmqrhvd2BQc16p/0E
        vnzV4/XnDox5ff+TwQmX+luaqj+XGbxh2/a1d1qcgtqtXUv9JC//iFkUu3dy+reN237lzZto
        IHL2W1HuMrcvDAxnlvb7BSl8+HFOeImARbLdNqkNzQ6zF3dW5rsFdKWs+3ng7U8lluKMREMt
        5qLiRACwt5iciQIAAA==
X-CMS-MailID: 20180418152719epcas2p11a0771ae5b032d8a3b4afa54e2c34553
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb
X-RootMTR: 20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb
References: <CGME20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb@epcas4p4.samsung.com>
        <20180418150617.22489-1-colin.king@canonical.com>
        <ebce8e36-9125-aecb-b0d1-87f068646e67@samsung.com>
        <bafbcf6c-a08d-11ba-af25-655b7cc44e1c@samsung.com>
        <c554a771-e9a9-fe1f-6792-e73f33b08838@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 05:24 PM, Colin Ian King wrote:
> Oops, shall I re-send?

There is no need to, thanks.
