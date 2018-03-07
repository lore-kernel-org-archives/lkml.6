Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbeCGRpu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:45:50 -0500
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:33154
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933478AbeCGRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:45:45 -0500
X-YMail-OSG: xBLNtAUVM1mDi7tTkLSJJhbSuaZQeygt8Cr_CAStHizzO33mpRFzlogiH3_7rKj
 vGserMFLw0PrqeZHqk.35J.Kl2uvKHUqQcPvgVO6LF9UO7nlbwoF_WIbqiEi.G3fNxGrLDH3F6co
 0_VnnVrai98P8kj.guc6cfAdQAk_CRK6uv_YQg.WSGW9cqE9Ddz8N32QUKJeRSkI9GvgJErvvJ5b
 vqkOLIJqVOcmU4NQsSrSoRmYEiWw0TAYAHhoWkNT5YpVz408xqzSp6iBa927K8UGANBCi1Ubqt2N
 EYCUI8NTsiCn9Jj_fq585g0rwhGH7db6FnQ_4LQYNMZq_1YaoSh38vMXC4A1UkFxEdxt4vFXBj49
 2XDm0eP7jUY6Gxyd5bD7_WX7fXAjfYJptKx1Ku6BHd7a6LqKqGLWwezYRtJCB6TydHZyyWsD6BuH
 RqFThHL2z7COkBhzZHCkabDFw9x5aE23EkxXL__LZNH5H0EDRYYxKoEEMuFXGw2U71qPTy.P0aiB
 AVOrhMsjxtG9tdnS5XNR4AfOzTZHT7SxeK.5RKku_A1I62M8-
Subject: Re: [PATCH v4 1/3] security: Refactor LSM hooks into an array and
 enum
To: Sargun Dhillon <sargun@sargun.me>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com
References: <cover.1520407240.git.sargun@sargun.me>
 <3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
Date: Wed, 7 Mar 2018 09:45:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/2018 11:23 PM, Sargun Dhillon wrote:
> This commit should have no functional change. It changes the security hook
> list heads struct into an array. Additionally, it exposes all of the hooks
> via an enum. This loses memory layout randomization as the enum is not
> randomized.

Please explain why you want to do this. I still dislike it.
